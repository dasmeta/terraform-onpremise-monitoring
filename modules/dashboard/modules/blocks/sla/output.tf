output "result" {
  description = "description"
  value = [
    [
      { type = "sla-slo-sli/main", width : 5, height : 6, balancer_name = var.balancer_name },
      { type = "sla-slo-sli/latency", width : 5, height : 6, balancer_name = var.balancer_name },
      { type = "sla-slo-sli/latency", width : 14, height : 6, balancer_name = var.balancer_name, histogram : true }
    ],
  ]
}
