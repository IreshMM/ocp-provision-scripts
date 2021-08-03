#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

vcd vm reset "$1" ocp-svc

vcd vm undeploy "$1" ocp-svc

vcd vm delete "$1" ocp-svc

#vcd vapp network delete "$1" natnet
