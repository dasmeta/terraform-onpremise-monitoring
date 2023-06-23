terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.40.0"
    }
  }
}

provider "grafana" {
  url  = "https://grafana.example.com/"
  auth = "xxxxxxx"
}
