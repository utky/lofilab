output "nameworkload_identity_provider" {
  value = module.wif.workload_identity_provider
}

output "service_account_email" {
  value = module.wif.service_account_email
}

output "repository_uri" {
  value = module.repository.uri
}
