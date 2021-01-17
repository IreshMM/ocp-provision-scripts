#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

vcd vapp delete -y -f "$1"

vcd network isolated delete -y ocp.lan

vcd disk delete -y ocp-bootstrap-disk

for instance in {1..3}; do
  vcd disk delete -y "ocp-cp-${instance}-disk"
done

for instance in {1..2}; do
  vcd disk delete -y "ocp-w-${instance}-disk"
done
