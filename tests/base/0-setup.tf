terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3.7.0"
    }
  }
}

# please start grafana locally using `docker compose up -d` (the compose.yaml is in ./tests folder) before running the test
provider "grafana" {
  url  = "http://localhost:3000"
  auth = "admin:admin"
}

