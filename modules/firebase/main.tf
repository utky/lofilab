variable "project_id" {
  description = "The ID of the project to create."
  type        = string
  
}


resource "google_firebase_project" "main" {
  provider = google-beta

  project = var.project_id
}
