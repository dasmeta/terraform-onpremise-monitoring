terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    grafana = {
      source = "grafana/grafana"
    }
  }
}

provider "grafana" {
  url  = "https://grafana.example.com/"
  auth = "glsa_1Ynadeezh63x3_asfsafaf23dsaad4"
}
