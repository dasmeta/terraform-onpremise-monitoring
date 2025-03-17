# grafana

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 5.0 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 3.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_grafana_cloudwatch_role"></a> [grafana\_cloudwatch\_role](#module\_grafana\_cloudwatch\_role) | dasmeta/iam/aws//modules/role | 1.3.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.grafana](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | certificate arn for grafana | `string` | `"arn:aws:acm:us-east-2:774305617028:certificate/0c7b32a5-cfd3-488b-800c-fe289f3bb040"` | no |
| <a name="input_cloudwatch_datasource"></a> [cloudwatch\_datasource](#input\_cloudwatch\_datasource) | boolean flag to enable cloudwatch datasource | `bool` | `true` | no |
| <a name="input_folder_uid"></a> [folder\_uid](#input\_folder\_uid) | n/a | `string` | `""` | no |
| <a name="input_grafana_admin_password"></a> [grafana\_admin\_password](#input\_grafana\_admin\_password) | admin password | `string` | `"Phkww5EWRHuSxKI"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | namespace to use for deployment | `string` | `"monitoring"` | no |
| <a name="input_prometheus_url"></a> [prometheus\_url](#input\_prometheus\_url) | url for prometheus datasource | `string` | `"http://prometheus-operated.monitoring.svc.cluster.local:9090"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
