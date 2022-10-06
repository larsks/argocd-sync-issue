#!/bin/bash

cluster=$1
shift

KUBECONFIG="run/kubeconfig-${cluster}"
export KUBECONFIG

exec "$@"
