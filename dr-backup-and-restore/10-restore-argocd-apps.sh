#!/bin/bash

NAMESPACE="crossplane-system"

# === 3. Scale up Crossplane core controller ===
echo "Scaling up Crossplane core controller..."
kubectl -n "$NAMESPACE" scale deployment crossplane --replicas=1

# === 4. Scale up all Crossplane provider deployments ===
echo "Scaling up all Crossplane providers..."
PROVIDERS=$(kubectl get deployments -n "$NAMESPACE" -o name | grep provider-)
for dep in $PROVIDERS; do
  echo "Scaling up $dep..."
  kubectl -n "$NAMESPACE" scale "$dep" --replicas=1
done

echo "✅ Crossplane components scaled up successfully."
