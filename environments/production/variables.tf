variable "project_id" {
  type        = string
  description = "Google CloudのプロジェクトID"
}

variable "region" {
  type        = string
  description = "リソースを作成するリージョン"
  default     = "asia-northeast1"
}

variable "github_repos" {
  description = "A list of GitHub repositories in the format of <owner>/<repository>"
  type        = list(string)
}

variable "repository_id" {
  description = "The ID of the Artifact Registry repository."
  type        = string
  default     = "utky-applications"
}
