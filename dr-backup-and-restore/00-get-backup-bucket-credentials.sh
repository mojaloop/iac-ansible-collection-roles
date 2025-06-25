#!/bin/bash

# Variables
NAMESPACE="velero"
SECRET_NAME="cloud-credentials"
STORAGE_LOCATION_NAME="control-center-backup"
OUTPUT_DIR="tmp"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# --- Step 1: Save the full Secret (data preserved, base64-encoded) ---
echo "Saving secret '$SECRET_NAME' from namespace '$NAMESPACE'..."

SECRET_OUTPUT_FILE="$OUTPUT_DIR/$SECRET_NAME.secret.yaml"
kubectl get secret "$SECRET_NAME" -n "$NAMESPACE" -o yaml > "$SECRET_OUTPUT_FILE"
echo "Saved full secret to '$SECRET_OUTPUT_FILE'"

# --- Step 2: Save BackupStorageLocation ---
echo "Saving BackupStorageLocation '$STORAGE_LOCATION_NAME' from namespace '$NAMESPACE'..."

BSL_OUTPUT_FILE="$OUTPUT_DIR/$STORAGE_LOCATION_NAME.backupstoragelocation.yaml"
kubectl get backupstoragelocation "$STORAGE_LOCATION_NAME" -n "$NAMESPACE" -o yaml > "$BSL_OUTPUT_FILE"
echo "Saved BackupStorageLocation to '$BSL_OUTPUT_FILE'"

echo "Done."
