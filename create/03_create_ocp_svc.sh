#!/bin/bash

vcd vapp network create-ovdc-network ocp-cluster natnet

cd ../terraform/

terraform apply --auto-approve

vcd vm add-nic --adapter-type VMXNET3 --primary --connect --network natnet --ip-address-mode DHCP ocp-cluster ocp-svc

vcd vm add-nic --adapter-type VMXNET3 --connect --network ocp.lan --ip-address-mode DHCP ocp-cluster ocp-svc
