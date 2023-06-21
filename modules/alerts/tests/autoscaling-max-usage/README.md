## Maximum Replica Count
This test case demonstrates how to configure Grafana alerts for an application reaching its maximum replica count. The alerts will notify you when the available replicas of a specific microservice have reached the maximum value for an extended period.

In this test, we have set up two alert rules for different microservices, `App_1` and `App_2`, within the `Autoscaling Test` folder. The alerts are triggered based on the Prometheus datasource and the metric `kube_deployment_status_replicas_available`.

For each microservice, we have specified a filter to match the deployment name (`app-1-microservice` and `app-2-microservice`). The `mean` function is applied to aggregate the metric values, and the condition `$B >= 20` is used to check if the replicas available are equal to or greater than 20.
