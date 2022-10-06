#!/bin/bash

echo "creating $1"
kind --kubeconfig "run/kubeconfig-$1" create cluster -n "$1" || exit 1
exec ./wait-for-cluster.sh "$1"
