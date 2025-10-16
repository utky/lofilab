variable "project_id" {
  description = "The ID of the project in which the service will be enabled."
  type        = string
  
}

resource "google_project_service" "main" {
  project  = var.project_id
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firebase.googleapis.com",
    "serviceusage.googleapis.com",
    "iamcredentials.googleapis.com",
    "secretmanager.googleapis.com",
    "artifactregistry.googleapis.com",
    "iap.googleapis.com",
    "run.googleapis.com",
    "dns.googleapis.com",
    "aiplatform.googleapis.com",
    "iam.googleapis.com",
  ])
  service = each.key

  # Don't disable the service if the resource block is removed by accident.
  disable_on_destroy = false
}
