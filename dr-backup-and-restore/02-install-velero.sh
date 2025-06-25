#!/bin/bash

set -euo pipefail

NAMESPACE="velero"
RELEASE_NAME="velero"
CLUSTER_FOLDER_NAME="cc04"
VALUES_FILE="$CLUSTER_FOLDER_NAME/velero-values.yaml"

echo "🔧 Creating namespace: $NAMESPACE"
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "🔐 Applying secret: cloud-credentials.secret.yaml"
kubectl apply -f $CLUSTER_FOLDER_NAME/tmp/cloud-credentials.secret.yaml

echo "📦 Adding Velero Helm repo"
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts
helm repo update

echo "🚀 Installing Velero with Helm and values.yaml"
helm upgrade --install "$RELEASE_NAME" vmware-tanzu/velero \
  --namespace "$NAMESPACE" \
  --values "$VALUES_FILE"

echo "📁 Applying backup storage location: backup-location.yaml"
kubectl apply -f $CLUSTER_FOLDER_NAME/tmp/control-center-backup.backupstoragelocation.yaml

echo "✅ Velero installation complete."
