terraform {
  required_version = ">= 1.3.0"

  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~>3.21.0 "
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

# you can start dev grafana server locally using `docker compose up -d` from `/tests` folder before running the test locally
provider "grafana" {
  url  = "https://grafana.example.com"
  auth = "admin:admin"

}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
