#!/bin/bash
# shellcheck disable=SC2016

list_clusters() {
	if [ -n "$*" ]; then
		tr ' ' '\n' <<<"$*"
	else
		find argocd/cluster* -maxdepth 0 -printf "%f\n"
	fi
}

die() {
	echo "ERROR: $1" >&2
	exit 1
}

if [ -d run ]; then
	echo "Found old session; run ./teardown.sh first" >&2
	exit 1
fi

mkdir -p run

echo "creating clusters"
list_clusters "$@" |
	xargs -P0 -INAME ./create-cluster.sh NAME ||
	die "failed to create clusters"

echo "bootstrapping argocd"
list_clusters "$@" |
	xargs -P0 -INAME ./bootstrap-cluster.sh NAME ||
	die "failed to bootstrap clusters"

echo "installing applications"
list_clusters "$@" |
	xargs -P0 -INAME ./install-apps.sh NAME ||
	die "failed to install apps to clusters"

echo "Your clusters are ready!"
