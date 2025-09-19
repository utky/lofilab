
resource "google_artifact_registry_repository" "docker" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }

  cleanup_policies {
    id     = "delete-untagged"
    action = "DELETE"
    condition {
      tag_state    = "UNTAGGED"
    }
  }

  cleanup_policies {
    id     = "keep-last"
    action = "KEEP"
    most_recent_versions {
      keep_count = 3
    }
  }
}
