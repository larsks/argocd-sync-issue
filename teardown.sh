#!/bin/bash
# shellcheck disable=2038

find argocd/cluster* -maxdepth 0 -printf "%f\n" |
	xargs -P0 -INAME kind delete cluster --kubeconfig run/kubeconfig-NAME -n NAME

find run/*.pid -print | xargs cat | xargs kill -9 > /dev/null 2>&1

rm -rf run
