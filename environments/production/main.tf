terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  backend "gcs" {
    bucket = "lofilab-admin-tfstate"
    prefix = "terraform/state/production"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region

  default_labels = {
    "environment" = "production",
    "managed-by"  = "terraform"
  }
}

module "wif" {
  source       = "../../modules/wif"
  project_id   = var.project_id
  github_repos = var.github_repos
}

module "repository" {
  source        = "../../modules/repository"
  project_id    = var.project_id
  location      = var.region
  repository_id = var.repository_id
}

module "dns" {
  source     = "../../modules/dns"
  project_id = var.project_id
}
