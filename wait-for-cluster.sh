#!/bin/bash
# shellcheck disable=SC2016

trap "" INT

timeout --foreground 120 sh -c '
	while ! ./cluster.sh $1 kubectl cluster-info > /dev/null 2>&1; do sleep 1; done
' -- "$@"
