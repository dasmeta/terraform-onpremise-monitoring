## High Restart Count
This test case demonstrates how to configure Grafana alerts for monitoring high restart counts of microservice containers. The alerts will notify you when the restart count of a specific container exceeds a predefined threshold.

In this test, we have set up two alert rules to monitor the restart count of microservice containers. The alerts are categorized within the `Restarts Test` folder. They utilize the Prometheus datasource and the metric `kube_pod_container_status_restarts_total`.

For each microservice, we have specified a filter to match the container name (`app-1-container` and `app-2-container`). The `mean` function is used to aggregate the restart count values.

The conditions `$B > 2` and `$B >= 4` are employed to check if the restart count exceeds the thresholds for each microservice. When the conditions are met, indicating a high restart count, the alerts will be triggered.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_test"></a> [test](#provider\_test) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| test_assertions.dummy | resource |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
