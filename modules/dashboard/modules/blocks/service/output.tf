output "result" {
  description = "description"
  value = [
    [
      { type : "text/title-with-collapse", text : var.name }
    ],
    concat(
      var.host != null ? [
        { type : "container/request-count", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace },
        { type : "container/request-count", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, only_5xx : true },
        { type : "container/response-time", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace },
      ] : [],
      [
        { type : "container/network", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, width : var.host != null ? 6 : 24, anomaly_detection : true },
      ]
    ),
    [
      { type : "container/cpu", container : var.name, cluster : var.cluster, namespace : var.namespace, anomaly_detection : true },
      { type : "container/memory", container : var.name, cluster : var.cluster, namespace : var.namespace, anomaly_detection : true },
      { type : "container/replicas", container : var.name, cluster : var.cluster, namespace : var.namespace },
      { type : "container/restarts", container : var.name, cluster : var.cluster, namespace : var.namespace },
    ],
    [
      { type : "container/cpu", container : var.name, cluster : var.cluster, namespace : var.namespace, anomaly_detection : true, by_pod : true, width : 24 },
    ],
  ]
}
