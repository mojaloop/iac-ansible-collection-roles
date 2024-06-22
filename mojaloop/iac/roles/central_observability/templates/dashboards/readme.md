# Dashboard notes
## k8s
- All dashboards sourced from grafana.com. See [github.com/dotdc/grafana-dashboards-kubernetes](https://github.com/dotdc/grafana-dashboards-kubernetes)

## Kafka
- `dashboard-kafka-topic-overview.json` is sourced from [github.com/mojaloop/helm](https://github.com/mojaloop/helm/blob/main/monitoring/dashboards/messaging/dashboard-kafka-topic-overview.json)
- All other dashboards are sourced from [github.com/strimzi/strimzi-kafka-operator](https://github.com/strimzi/strimzi-kafka-operator/tree/0.41.0/examples/metrics/grafana-dashboards)
- Some kafka dashboards (e.g. Strimzi Kafka Exporter) do not have the ability to query data on per cluster basis. Issue has been raised with strimzi kafka team on CNCF/strimmi-kafka slack   

## minio
- All dashboards sourced from grafana.com See [minio](https://min.io/docs/minio/container/operations/monitoring/grafana.html#minio-server-grafana-metrics) documentation

## mojaloop
- All dashboards sourced from [github.com/mojaloop/helm](https://github.com/mojaloop/helm/tree/main/monitoring/dashboards/mojaloop)