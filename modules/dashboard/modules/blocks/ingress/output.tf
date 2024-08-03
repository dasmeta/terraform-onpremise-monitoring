output "result" {
  description = "description"
  value = [
    [
      { type : "text/title-with-collapse", text : "Nginx Ingress Controller" }
    ],
    [
      { type : "ingress/request-rate" },
      { type : "ingress/connections" },
      { type : "ingress/response-time" },
      { type : "ingress/request-count" }
    ],
    [
      { type : "ingress/request-rate", by_host : true },
      { type : "ingress/response-time", by_host : true },
      { type : "ingress/request-count", by_host : true },
      { type : "ingress/request-count", by_host : true, only_5xx: true }
    ],
    [
      { type : "container/cpu", container : "controller", namespace : "ingress-nginx", width : 12 },
      { type : "container/memory", container : "controller", namespace : "ingress-nginx", width : 12 }
    ],
  ]
}
