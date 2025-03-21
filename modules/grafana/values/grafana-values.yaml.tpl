
persistence:
  enabled: true
  type: pvc
  size: 10Gi

ingress:
  enabled: true
  annotations:
%{~ for k, v in INGRESS_ANNOTATIONS }
    ${k}: "${v}"
%{~ endfor }
  hosts:
%{ for h in INGRESS_HOSTS ~}
    - ${h}
%{ endfor ~}
  path: ${INGRESS_PATH}
  pathType: ${INGRESS_PATH_TYPE}

datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
%{~ if PROMETHEUS_ENABLE }
      - name: Prometheus
        type: prometheus
        access: proxy
        url: ${PROMETHEUS_URL}
        isDefault: true
        editable: true
%{~ endif }
%{~ if CLOUDWATCH_ENABLE }
      - name: CloudWatch
        type: cloudwatch
        access: proxy
        uid: cloudwatch
        editable: false
        jsonData:
          authType: default
          assumeRoleArn: ${CLOUDWATCH_ROLE_ARN}
          defaultRegion: ${AWS_REGION}
%{~ endif }

replicas: 1
image.tag: "11.4.2"

resources:
  requests:
    cpu: ${REQUEST_CPU}
    memory: ${REQUEST_MEMORY}
  limits:
    cpu: ${LIMIT_CPU}
    memory: ${LIMIT_MEMORY}

serviceMonitor:
  enabled: true
  namespace: monitoring
  selector:
    matchLabels:
      release: prometheus
