output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = module.cert-manager.id
}

output "issuers" {
  description = "List of issuers created by cert-manager"
  value       = module.cert-manager.issuers
}
