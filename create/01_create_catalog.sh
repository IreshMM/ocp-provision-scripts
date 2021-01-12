#!/bin/bash

vcd catalog create iso
vcd catalog upload -p iso rhcos.iso
