#!/bin/bash
# shellcheck disable=SC2016

echo "installing argocd in cluster $1"
./cluster.sh "$1" kubectl apply -k bootstrap

echo "waiting for argocd in $1 to become ready"
timeout 120 sh -c '
	while ! ./cluster.sh $1 kubectl -n argocd get deploy/argocd-server > /dev/null 2>&1; do sleep 1; done
	while ! ./cluster.sh $1 kubectl -n argocd wait --for=condition=Available deploy/argocd-server > /dev/null 2>&1; do sleep 1; done
' -- "$@"
