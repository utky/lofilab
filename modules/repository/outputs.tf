output "uri" {
  description = "The URI of the repository."
  value       = google_artifact_registry_repository.docker.registry_uri
}
