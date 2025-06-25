1. Download backup
2. extract Persistent Volume resources from it
3. Combined extraced pv's from backup
    ```
    for f in pvc-*.json
        jq 'del(.spec.claimRef) | .spec.persistentVolumeReclaimPolicy = "Retain"' $f | yq -P >> combined-pvs.yaml
        echo '---' >> combined-pvs.yaml
    end
    ```
    that will remove spec.claimRef and change reclaim policy to Retain which we need for restore
4. Apply combined-pvs.yaml to the cluster
