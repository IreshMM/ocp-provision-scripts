#!/bin/bash
HOME=/root

wget -O $HOME/openshift-install.tar.gz "$1"
wget -O $HOME/openshift-client.tar.gz "$2"

tar xvf $HOME/openshift-client.tar.gz -C $HOME
mv $HOME/oc $HOME/kubectl /usr/local/bin

kubectl version
oc version

tar xvf $HOME/openshift-install.tar.gz -C $HOME

git clone https://github.com/ryanhay/ocp4-metal-install

