#!/bin/bash

vcd vapp create -d 'VM Cluster for OCP cluster' ocp-cluster
vcd network isolated create \
              -g 192.168.22.1 \
              -n 255.255.255.0 \
              --dhcp-disabled \
              ocp.lan

vcd vapp network create-ovdc-network ocp-cluster ocp.lan

# $1 -> Cluster name
# $2 -> VM name
# $3 -> CPUs
# $4 -> Memory
# $5 -> Disk size
# $6 -> Media <catalog> <media_name>
create_vm() {
vcd vapp add-vm-scratch -vm "$2"\
                        -cn "$2"\
                        -os 'coreos64Guest' \
                        -cpu $3 \
                        -cps $3 \
                        -m $((1024 * $4)) \
                        -deploy \
                        "$1"

vcd disk create -s Standard "$2"-disk $((1024 ** 3 * $5))

vcd vapp attach "$1" "$2" "$2"-disk

vcd vm insert-cd \
    --media-id `vcd -j catalog info $6 | jq -r '."template-id"'` \
    "$1" \
    "$2"

vcd vm add-nic \
            --adapter-type VMXNET3 \
            --network ocp.lan \
            --primary \
            --connect \
            "$1" \
            "$2"
}

create_vm "ocp-cluster" "ocp-bootstrap" 6 6 40 "iso rhcos.iso"

# Create control plane
for instance in {1..3}; do
  create_vm "ocp-cluster" "ocp-cp-${instance}" 4 8 50 "iso rhcos.iso"
done

# Create compute nodes
for instance in {1..2}; do
  create_vm "ocp-cluster" "ocp-w-${instance}" 4 8 50 "iso rhcos.iso"
done
