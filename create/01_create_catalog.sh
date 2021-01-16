#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the link to the iso"
  exit 1
fi

wget -O rhcos.iso "$1"

vcd catalog create iso
vcd catalog upload -p iso rhcos.iso
