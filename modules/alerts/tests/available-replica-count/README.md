## No Available Replicas
This test case demonstrates how to configure Grafana alerts for detecting when an application doesn't have any available replicas. The alerts will notify you when the available replicas of a specific microservice drop to zero.

In this test, we have set up two alert rules to detect when the available replicas of the microservices drop to zero. The alerts are organized within the `Replica Count Test` folder. They rely on the Prometheus datasource and the metric `kube_deployment_status_replicas_available`.

For each microservice, we have specified a filter to match the deployment name (`app-1-microservice` and `app-2-microservice`). The `last` function is used to process the metric values, respectively.

The condition `$B < 1` is used to check if the available replicas fall below 1, indicating that the application doesn't have any replicas.
