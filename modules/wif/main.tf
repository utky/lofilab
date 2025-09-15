resource "google_iam_workload_identity_pool" "github_pool" {
  project                   = var.project_id
  workload_identity_pool_id = "${var.prefix}-pool"
  display_name              = "${var.prefix} Pool"
  description               = "Workload Identity Pool for GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "${var.prefix}-provider"
  display_name                       = "${var.prefix} Provider"
  description                        = "Workload Identity Pool Provider for GitHub Actions"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  attribute_condition = <<EOT
    assertion.repository_owner == "utky" &&
    assertion.ref == "refs/heads/main" &&
    assertion.ref_type == "branch"
EOT

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "${var.prefix}"
  display_name = "GitHub Actions Service Account"
}

resource "google_project_iam_member" "wif_user" {
  for_each = toset(var.github_repos)

  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${each.value}"
}

resource "google_project_iam_member" "sa_roles" {
  for_each = toset(var.service_account_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.github_actions.email}"
}
