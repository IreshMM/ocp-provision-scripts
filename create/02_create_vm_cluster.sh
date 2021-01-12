#!/bin/bash

vcd vapp create -d 'VM Cluster for OCP cluster' ocp-cluster

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
    ocp-cluster \
    ocp-bootstrap

}


create_vm "ocp-cluster" "ocp-bootstrap" 6 6 40 "iso rhcos.iso"
