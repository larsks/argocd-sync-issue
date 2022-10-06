#!/bin/bash

exec ./cluster.sh "$1" kubectl apply -k "argocd/$1"
