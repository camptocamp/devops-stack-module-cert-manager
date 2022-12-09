data "azurerm_resource_group" "node_resource_group" {
  name = var.node_resource_group_name
}

data "azurerm_subscription" "primary" {
}

resource "azurerm_user_assigned_identity" "cert_manager" {
  resource_group_name = data.azurerm_resource_group.node_resource_group.name
  location            = data.azurerm_resource_group.node_resource_group.location
  name                = "cert-manager"
}

data "azurerm_dns_zone" "this" {
  name                = var.base_domain
  resource_group_name = var.dns_zone_resource_group_name
}

resource "azurerm_role_assignment" "dns_zone_contributor" {
  scope                = data.azurerm_dns_zone.this.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.cert_manager.principal_id
}

module "cert-manager" {
  source = "../"

  cluster_name     = var.cluster_name
  base_domain      = var.base_domain
  argocd_namespace = var.argocd_namespace

  namespace    = var.namespace
  target_revision = var.target_revision
  app_autosync = var.app_autosync

  helm_values = concat(local.helm_values, var.helm_values)

  dependency_ids = var.dependency_ids
}
