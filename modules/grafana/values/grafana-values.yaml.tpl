persistence:
  enabled: true
  type: pvc
  size: 10Gi

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
    alb.ingress.kubernetes.io/group.name: dev-ingress
    alb.ingress.kubernetes.io/healthcheck-path: "/login"
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: "15"
    alb.ingress.kubernetes.io/group.order: "20"
    alb.ingress.kubernetes.io/ssl-redirect: "443"
    alb.ingress.kubernetes.io/success-codes: "200-399"
    alb.ingress.kubernetes.io/certificate-arn: ${INGRESS_CERTIFICATE}
  hosts:
    - grafana.dev.trysela.com
  path: /
  pathType: Prefix

datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
      - name: Prometheus
        type: prometheus
        access: proxy
        url: ${PROMETHEUS_URL}
        isDefault: true
        editable: true
      - name: CloudWatch
        type: cloudwatch
        access: proxy
        uid: cloudwatch
        editable: false
        jsonData:
          authType: default
          assumeRoleArn: ${CLOUDWATCH_ROLE_ARN}
          defaultRegion: ${AWS_REGION}

replicas: 2
image.tag: "11.4.2"

resources:
  requests:
    cpu: 500m
    memory: 1000Mi
  limits:
    cpu: 1000m
    memory: 1500Mi

serviceMonitor:
  enabled: true
  namespace: monitoring
  selector:
    matchLabels:
      release: prometheus
