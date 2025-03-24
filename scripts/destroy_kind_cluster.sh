# helm uninstall trainer
# helm uninstall inference
# helm uninstall monitor

#!/usr/bin/env bash
set -e

CLUSTER_NAME="mnist-cluster"

echo "Deleting Kind cluster named $CLUSTER_NAME..."
kind delete cluster --name "$CLUSTER_NAME"

echo "Kind cluster '$CLUSTER_NAME' deleted."
