output "result" {
  description = "description"
  value = [
    [
      { type : "text/title-with-collapse", text : var.name }
    ],
    [
      { type : "pod/cpu", pod : var.name, cluster : var.cluster, namespace : var.namespace, anomaly_detection : true, width : 6 },
      { type : "pod/memory", pod : var.name, cluster : var.cluster, namespace : var.namespace, anomaly_detection : true, width : 6 },
      { type : "deployment/replicas", deployment : var.name, cluster : var.cluster, namespace : var.namespace, width : 6 },
      { type : "pod/restarts", pod : var.name, cluster : var.cluster, namespace : var.namespace, width : 6 },
    ],
    concat(
      [
        { type : "container/network", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, width : var.host != null ? 6 : 24, anomaly_detection : true, width : 6 },
        { type : "container/network-transmit", host : var.host, pod : var.name, cluster : var.cluster, namespace : var.namespace, width : var.host != null ? 6 : 24, anomaly_detection : true, width : 6 },
      
      ],
      var.host != null ? [
        { type : "container/request-count", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, width: 4 },
        { type : "container/request-count", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, only_5xx : true, width: 4 },
        { type : "container/response-time", host : var.host, container : var.name, cluster : var.cluster, namespace : var.namespace, width: 4 },
      ] : [],
    ),
  ]
}
