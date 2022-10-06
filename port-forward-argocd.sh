#!/bin/bash

cluster=$1
num="${cluster#cluster}"
hostaddr="127.0.0.$num"

sh -c '
	while ! curl -sf -o /dev/null http://$1:8080; do
		sleep 1
	done

	xdg-open http://$1:8080
' -- "$hostaddr" &

exec ./cluster.sh "$cluster" kubectl \
	-n argocd port-forward service/argocd-server \
	--address "$hostaddr" "8080:80" > /dev/null 2>&1
