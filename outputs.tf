output "id" {
  description = "ID to pass other modules in order to refer to this module as a dependency."
  value       = resource.null_resource.this.id
}

output "issuers" {
  description = "List of issuers created by cert-manager"
  value       = local.issuers
}
