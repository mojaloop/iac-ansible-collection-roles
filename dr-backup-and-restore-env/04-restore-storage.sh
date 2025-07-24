#!/bin/bash

# === Configuration ===
RESTORE_FILE="restoreTemplates/02-restore-storage.yaml"
RESTORE_NAME=$(yq '.metadata.name' "$RESTORE_FILE")

# === 1. Apply the restore YAML ===
echo "Applying restore from $RESTORE_FILE..."
kubectl apply -f "$RESTORE_FILE"

sleep 5

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
