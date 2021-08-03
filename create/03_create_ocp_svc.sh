#!/bin/bash -x

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

VAPP_NAME="$1"
NETWORK_NAME="${VAPP_NAME}-ocp.lan"

vcd vapp network create-ovdc-network "$VAPP_NAME" routed-nat-net

cd ../terraform/
terraform workspace select default
terraform workspace delete --force x
terraform workspace new x
terraform workspace select x
TF_VAR_vapp="$VAPP_NAME" terraform apply --auto-approve

vcd vm add-nic --adapter-type VMXNET3 --primary --connect --network routed-nat-net --ip-address-mode DHCP "$VAPP_NAME" "ocp-svc"

vcd vm add-nic --adapter-type VMXNET3 --connect --network "$NETWORK_NAME" --ip-address-mode DHCP "$VAPP_NAME" "ocp-svc"

