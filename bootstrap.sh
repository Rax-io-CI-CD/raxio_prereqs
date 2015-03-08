#!/usr/bin/env bash
# add the ppa ansible repo so we may get the latest
sudo apt-get install software-properties-common python-software-properties unzip -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
# some essentials and pip
sudo apt-get install build-essential git \
  software-properties-common python-software-properties \
  python-pip python2.7-dev python-setuptools ansible curl vim unzip -y
sudo pip install pyrax
sudo pip install --upgrade six

sudo wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
sudo unzip sonar-runner-dist-2.4.zip -d /opt
