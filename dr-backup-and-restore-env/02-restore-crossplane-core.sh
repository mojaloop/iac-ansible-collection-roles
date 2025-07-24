#!/bin/bash

# === Configuration ===
RESTORE_FILE="restoreTemplates/01-crossplane-core-restore.yaml"
RESTORE_NAME=$(yq '.metadata.name' "$RESTORE_FILE")
NAMESPACE="crossplane-system"

# === 1. Apply the restore YAML ===
echo "Applying restore from $RESTORE_FILE..."
kubectl apply -f "$RESTORE_FILE"

# === 2. Wait for the restore to complete ===
echo "Waiting for Velero restore [$RESTORE_NAME] to complete..."
while true; do
  STATUS=$(velero restore get "$RESTORE_NAME" -o json | jq -r '.status.phase')
  echo "Current status: $STATUS"
  if [[ "$STATUS" == "Completed" || "$STATUS" == "PartiallyFailed" || "$STATUS" == "Failed" ]]; then
    break
  fi
  sleep 5
done

## TODO Scaledown crossplane core pods

# === 3. Scale down all Crossplane provider deployments ===
echo "Scaling down all Crossplane providers..."
PROVIDERS=$(kubectl get deployments -n "$NAMESPACE" -o name | grep provider-)
for dep in $PROVIDERS; do
  echo "Scaling down $dep..."
  kubectl -n "$NAMESPACE" scale "$dep" --replicas=0
done

echo "✅ Restore applied and Crossplane components scaled down."
