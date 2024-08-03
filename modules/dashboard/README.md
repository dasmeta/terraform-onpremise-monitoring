# Module to create Grafana dashboard from json/hcl
## Yaml example
```
source: dasmeta/grafana/onpremise//modules/dashboard
version: x.y.z
variables:
  name: test-dashboard
  data_source:
    uid: "0000"
  rows:
    - type : block/sla
    - type : "block/ingress"
    - type : "block/service"
      name : "service-name-1"
      host : "example.com"
    - type : "block/service",
      name : "service-name-2"
    - 
      - type : "text/title",
        text : "End"
```

## HCL example
```
module "this" {
  source  = "dasmeta/grafana/onpremise//modules/dashboard"
  version = "x.y.z"

  name        = "test-dashboard-with-blocks"
  data_source = {
    uid: "0000"
  }

  rows = [
    { "type" : "block/sla" },
    { type : "block/ingress" },
    { type : "block/service", name : "service-name-1", namespace: "dev", host : "example.com" },
    { type : "block/service", name : "service-name-2", namespace: "dev" },
    { type : text/title, text: "End"}
  ]
}
```

## How add new widget
1. create module in modules/widgets (copy from one)
2. implement data loading as required
3. add new widget tf module in widget-{widget-group-name | single}.tf file
4. add new widget line in widget_result local

## How add new block
1. create module in modules/blocks (copy from one)
2. implement data loading as required
3. add new block tf module in widget-blocks.tf
4. add new block line in blocks_results local
