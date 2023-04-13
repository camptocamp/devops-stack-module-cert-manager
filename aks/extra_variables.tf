variable "node_resource_group_name" {
  description = "The managed AKS resource group name."
  type        = string
}

variable "dns_zone_resource_group_name" {
  description = "The Azure DNS zone's resource group name."
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  type        = string
}
