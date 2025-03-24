# kubectl create namespace digits
# helm install trainer services/trainer/helm-chart -n digits
# helm install inference services/inference/helm-chart -n digits
# helm install monitor services/monitor/helm-chart -n digits

#!/usr/bin/env bash
set -e

CLUSTER_NAME="mnist-cluster"

echo "Creating Kind cluster named $CLUSTER_NAME..."
kind create cluster --name "$CLUSTER_NAME" --wait 60s

echo "Kind cluster '$CLUSTER_NAME' created."
kubectl cluster-info --context kind-$CLUSTER_NAME
