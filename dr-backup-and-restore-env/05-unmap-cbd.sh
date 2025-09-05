#!/bin/bash

NAMESPACE="storage"  # Adjust if needed (e.g., "rook-ceph")

echo "[INFO] Scanning all csi-rbdplugin pods in namespace: $NAMESPACE"

for pod in $(kubectl -n "$NAMESPACE" get pods -o name | grep csi-rbdplugin | grep -v provisioner); do
  echo "🔍 Checking pod: $pod"
  output=$(kubectl exec -n "$NAMESPACE" -c csi-rbdplugin "$pod" -- rbd device list 2>/dev/null)

  if [ -z "$output" ]; then
    echo "  ➤ No devices found in $pod"
    continue
  fi

  echo "$output" | grep -v '^id' | while read -r line; do
    vol=$(echo "$line" | awk '{print $3}')
    dev=$(echo "$line" | awk '{print $NF}')

    if [ -n "$dev" ]; then
      echo "  ⚠️  Found volume '$vol' mounted as $dev in $pod"
      echo "     ➤ Attempting to unmount and unmap..."

      kubectl exec -n "$NAMESPACE" -c csi-rbdplugin "$pod" -- umount "$dev" 2>/dev/null
      kubectl exec -n "$NAMESPACE" -c csi-rbdplugin "$pod" -- rbd unmap "$dev" 2>/dev/null

      echo "     ✅ Unmapped $dev (volume: $vol)"
    fi
  done
done

echo "[✅ DONE] All RBD devices have been processed."
