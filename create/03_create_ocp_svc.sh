#!/bin/bash -x

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

vcd vapp network create-ovdc-network "$1" natnet

cd ../terraform/
terraform workspace select default
terraform workspace delete --force x
terraform workspace new x
terraform workspace select x
TF_VAR_vapp="$1" terraform apply --auto-approve

vcd vm add-nic --adapter-type VMXNET3 --primary --connect --network natnet --ip-address-mode DHCP "$1" ocp-svc

vcd vm add-nic --adapter-type VMXNET3 --connect --network ocp.lan --ip-address-mode DHCP "$1" ocp-svc

