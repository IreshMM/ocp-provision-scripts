#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

./03_destroy_ocp_svc.sh "$1"
./02_destroy_vm_cluster.sh "$1"
./01_delete_catalog.sh
