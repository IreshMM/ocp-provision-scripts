#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

./01_create_catalog.sh "$2"
./02_create_vm_cluster.sh "$1"
./03_create_ocp_svc.sh "$1"
