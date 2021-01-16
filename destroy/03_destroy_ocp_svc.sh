#!/bin/bash
vcd vm reset ocp-cluster ocp-svc

vcd vm undeploy ocp-cluster ocp-svc

vcd vm delete ocp-cluster ocp-svc

vcd vapp network delete ocp-cluster natnet
