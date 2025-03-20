grafana:
  enabled: false

prometheusOperator:
  enabled: true
  tls:
    enabled: false

prometheus:
  enabled: true
  prometheusSpec:
    replicas: 2
    retention: ${RETENTION_DAYS} # 15d
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: ${STORAGE_CLASS_NAME} # efs-sc-root
          accessModes: ["ReadWriteMany"]
          resources:
            requests:
              storage: ${STORAGE_SIZE} # 50Gi
    resources:
      requests:
        memory: ${REQUEST_MEM} # 2Gi
        cpu: ${REQUEST_CPU} # 500m
      limits:
        memory: ${LIMIT_MEM} # 4Gi
        cpu: ${LIMIT_CPU} # 1000m
    serviceMonitorSelectorNilUsesHelmValues: false

alertmanager:
  enabled: ${ENABLE_ALERTMANAGER}
  alertmanagerSpec:
    replicas: 1
    resources:
      requests:
        memory: 512Mi
        cpu: 250m
      limits:
        memory: 1Gi
        cpu: 500m

kube-state-metrics:
  enabled: true

nodeExporter:
  enabled: true

prometheus-node-exporter:
  resources:
    requests:
      memory: 200Mi
      cpu: 100m
    limits:
      memory: 500Mi
      cpu: 200m

serviceMonitor:
  enabled: true
