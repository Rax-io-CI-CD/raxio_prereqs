#!/bin/bash -ex

# This script requires a "rackerlabs" remote that points to
# git@github.com:rackerlabs/arbor.git and an "upstream" remote that
# points to git://github.com/stackforge/solum.git

# downstream-patches.txt should be in the format:
# <git-remote> <remote-branch>
# <git-remote> <remote-branch>
# ...

usage="Usage: ./build-arbor -h HEAD -r REPO [-d DOWNSTREAM_VERSION] [-n] [-p PATCHES_FILE] [-o OUT_FILE] [-t]

Required arguments.
  -d  Downstream version of upstream version (used to tag the release).
  -h  Upstream git SHA1 to base release off of.  Uses latest HEAD by default.
  -n  Don't push to remote.  Just build locally.
  -o  File to write the generated branch/tag name to.
  -x  File with commands to remove unsupported resources
  -r  Path to Heat git repository.
  -t  Run unit tests (optional).
  -8  Run pep8.
  -e  Previous version for generating a changelog.
  -i  SSH key for gerrit reviews

Examples:
./build-arbor -h feeae7f -d 1 -r ~/github/arbor -o /tmp/arbor_version
./build-arbor -h feeae7f -r ~/github/arbor -o /tmp/arbor_version
"

push=1
release_head="latest"
checkout=$(pwd)
# Parse command-line options
while getopts "i:d:h:no:r:tv8z:e:" opt; do
    case "$opt" in
        d)  downstream_version=$OPTARG
            ;;
        h)  release_head=$OPTARG
            ;;
        n)  push=0
            ;;
        o)  out_file=$OPTARG
            ;;
        x)  remove_resources=$OPTARG
            ;;
        r)  arbor_repo=$OPTARG
            ;;
        t)  run_tests=1
            ;;
        8)  run_pep=1
            ;;
        e)  previous_version=$OPTARG
            ;;
        i)  ssh_key=$OPTARG
            ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            echo -e "$usage"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Make sure all required options have been given
if ! [[ $arbor_repo && $downstream_version ]]
then
    echo -e "The -r and -d options are required.\n"
    echo -e "$usage $arbor_repo $downstream_version"
    exit 1
fi

tox_tests() {
    if [[ $run_tests ]]; then
        if ! tox -e py27; then
            echo "Tests failed"
            exit 1
        fi
    fi
    if [[ $run_pep ]]; then
        if ! tox -e pep8; then
            echo "Pep8 failed"
            exit 2
        fi
    fi
}

# Construct upstream version string
cd $arbor_repo
git fetch upstream
if [[ $release_head == "latest" ]]; then
    sha1=$(git rev-parse upstream/master | cut -c1-7)
else
    sha1=$release_head
fi
upstream_version=$(date '+%Y%m%d')-g$sha1

branch=upstream

# Delete branch if it already exists
if git show-ref builds/$branch; then
    git checkout upstream/master
    git branch -D builds/$branch
fi

# Create a branch at upstream SHA1
git branch builds/$branch $sha1
git checkout builds/$branch
echo $branch

# Generate changelog
python $checkout/scripts/changelog.py --output changelog ${previous_version} builds/${branch}
git add changelog
git commit -m "Add release changelog for ${branch}"

# Run unit tests
tox_tests

# Remove unsupported resources
if [[ -e $checkout/supported_resources.txt ]]; then
    python $checkout/scripts/remove_unsupported.py $checkout/supported_resources.txt ./heat/engine/resources
    git commit -a -m "Remove unsupported resources."
fi

# Create a branch for the release type
if [[ $push -eq 1 ]]; then
    git push -f rackerlabs builds/$branch:refs/heads/$branch
fi
if [[ $out_file ]]; then
    echo $branch > $out_file
fi
