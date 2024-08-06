output "data" {
  value = try(
    module.base_grafana.data,
    null
  )
}
