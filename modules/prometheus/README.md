# prometheus

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | > 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >2.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_prometheus"></a> [enable\_prometheus](#input\_enable\_prometheus) | boolean flag to enable disable prometheus deployment | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | namespace to use for deployment | `string` | `"monitoring"` | no |
| <a name="input_prometheus_configs"></a> [prometheus\_configs](#input\_prometheus\_configs) | Values to send to Prometheus template values file | <pre>object({<br/>    retention_days = string<br/>    storage_class  = string<br/>    storage_size   = string<br/>    resources = object({<br/>      request = object({<br/>        cpu = string<br/>        mem = string<br/>      })<br/>      limit = object({<br/>        cpu = string<br/>        mem = string<br/>      })<br/>    })<br/>    enable_alertmanager = bool<br/>  })</pre> | <pre>{<br/>  "enable_alertmanager": true,<br/>  "resources": {<br/>    "limit": {<br/>      "cpu": "1",<br/>      "mem": "1Gi"<br/>    },<br/>    "request": {<br/>      "cpu": "500m",<br/>      "mem": "500Mi"<br/>    }<br/>  },<br/>  "retention_days": "15d",<br/>  "storage_class": "efs-sc",<br/>  "storage_size": "50Gi"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
