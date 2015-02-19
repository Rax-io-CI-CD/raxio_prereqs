#!/usr/bin/env bash
# add the ppa ansible repo so we may get the latest
sudo apt-get install software-properties-common python-software-properties -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
# some essentials and pip
sudo apt-get install build-essential git \
  software-properties-common python-software-properties \
  python-pip python2.7-dev python-setuptools ansible -y
sudo pip install pyrax
sudo pip install --upgrade six
