variable "project_id" {
  type = string
}

resource "google_dns_managed_zone" "main" {
  project     = var.project_id
  name        = "hushabye-net"
  dns_name    = "hushabye.net."
  description = "お名前ドットコムで取得した個人用ドメイン名"
}
