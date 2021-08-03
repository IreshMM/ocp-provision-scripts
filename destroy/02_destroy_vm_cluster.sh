#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

VAPP_NAME="${1:-ocp4}"
NETWORK_NAME="${VAPP_NAME}-ocp.lan"


vcd vapp delete -y -f "$VAPP_NAME"

vcd network isolated delete -y "$NETWORK_NAME"

vcd disk delete -y ocp-bootstrap-disk-$VAPP_NAME

for instance in {1..3}; do
  vcd disk delete -y "ocp-cp-${instance}-disk-$VAPP_NAME"
done

for instance in {1..2}; do
  vcd disk delete -y "ocp-w-${instance}-disk-$VAPP_NAME"
done
