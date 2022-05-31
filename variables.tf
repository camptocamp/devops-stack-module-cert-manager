#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "other_domains" {
  description = "Other domains used for Ingresses requiring a DNS-01 challenge for Let's Encrypt validation with cert-manager (e.g. wildcard certificates)."
  type        = list(string)
  default     = []
}

variable "argocd_namespace" {
  type = string
}

variable "namespace" {
  type    = string
  default = "cert-manager"
}

variable "helm_values" {
  description = "Helm values, passed as a list of HCL structures."
  type        = any
  default     = []
}

variable "dependency_ids" {
  type = map(string)

  default = {}
}

#######################
## Module variables
#######################
