
variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "location" {
  description = "The location of the repository."
  type        = string
}

variable "repository_id" {
  description = "The ID of the repository."
  type        = string
}

variable "description" {
  description = "The description of the repository."
  type        = string
  default     = "Docker repository for multiple applications"
}
