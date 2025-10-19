terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
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
  user_project_override = true

  default_labels = {
    "environment" = "production",
    "managed-by"  = "terraform"
    "terraform-provier" = "google"
  }
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  user_project_override = true

  default_labels = {
    "environment" = "production",
    "managed-by"  = "terraform"
    "terraform-provier" = "google-beta"
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

module "service_api" {
  source     = "../../modules/service_api"
  project_id = var.project_id
}

module "firebase" {
  source       = "../../modules/firebase"
  project_id   = var.project_id
}

import {
  id = "projects/${var.project_id}"
  to = module.firebase.google_firebase_project.main
}
