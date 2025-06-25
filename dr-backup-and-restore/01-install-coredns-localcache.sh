#!/bin/bash

set -euo pipefail

MANIFEST_FILE="coredns-localcache.yaml"

echo "📋 Checking if manifest file exists..."
if [[ ! -f "$MANIFEST_FILE" ]]; then
    echo "❌ Manifest file not found: $MANIFEST_FILE"
    exit 1
fi

echo "🚀 Installing CoreDNS local cache..."
kubectl apply -f "$MANIFEST_FILE"

echo "⏳ Waiting 5 seconds for installation to process..."
sleep 5

echo "⏳ Waiting for CoreDNS pods to be ready..."
kubectl wait --for=condition=ready pod -l k8s-app=coredns-nodecache -n kube-system --timeout=300s

echo "✅ CoreDNS local cache installation complete!"
echo "📊 Checking deployment status..."
kubectl get pods -l k8s-app=coredns-nodecache -n kube-system
