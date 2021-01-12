#!/bin/bash

vcd vapp delete -y -f ocp-cluster

vcd disk delete -y ocp-bootstrap-disk
