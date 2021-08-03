#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the link to the iso"
  exit 1
fi

ISO_URL="$1"
CATALOG="${2:-iso}"
ISO_NAME="${3:-rhcos.iso}"

wget -O "$ISO_NAME" "$ISO_URL"

vcd catalog create "$CATALOG"
vcd catalog upload -p "$CATALOG" "$ISO_NAME"
