# ingress

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | k8s namespace name | `string` | n/a | yes |
| <a name="input_redis_name"></a> [redis\_name](#input\_redis\_name) | Redis name | `string` | `"redis"` | no |
| <a name="input_redis_namespace"></a> [redis\_namespace](#input\_redis\_namespace) | k8s redis namespace name | `string` | n/a | yes |
| <a name="input_redis_pod"></a> [redis\_pod](#input\_redis\_pod) | Redis pod name, which may be the same with redis\_name | `string` | `"redis"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | description |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
