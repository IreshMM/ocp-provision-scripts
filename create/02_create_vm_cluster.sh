#!/bin/bash -x

if [ -z "$1" ]; then
  echo "Please enter the cluster name"
  exit 1
fi

VAPP_NAME="$1" # Cluster name
NETWORK_NAME="${VAPP_NAME}-ocp.lan"
CATALOG="$2"
ISO_NAME="$3"

vcd vapp create -d 'VM Cluster for OCP cluster' "$VAPP_NAME"
vcd network isolated create \
              -g 192.168.22.1 \
              -n 255.255.255.0 \
              --dhcp-disabled \
              "$NETWORK_NAME"

vcd vapp network create-ovdc-network "$VAPP_NAME" "$NETWORK_NAME"

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

DISK_NAME="$2-disk-$VAPP_NAME"
vcd disk create -s Standard "$DISK_NAME" $((1024 ** 3 * $5))

vcd vapp attach "$1" "$2" "$DISK_NAME"

vcd vm insert-cd \
    --media-id `vcd -j catalog info $6 | jq -r '."template-id"'` \
    "$1" \
    "$2"

vcd vm add-nic \
            --adapter-type VMXNET3 \
            --network "$NETWORK_NAME" \
            --primary \
            --connect \
            "$1" \
            "$2"
}

create_vm "$VAPP_NAME" "ocp-bootstrap" 6 16 120 "$CATALOG $ISO_NAME"

# Create control plane
for instance in {1..3}; do
  create_vm "$VAPP_NAME" "ocp-cp-${instance}" 4 16 120 "$CATALOG $ISO_NAME"
done

# Create compute nodes
for instance in {1..2}; do
  create_vm "$VAPP_NAME" "ocp-w-${instance}" 4 8 120 "$CATALOG $ISO_NAME"
done
