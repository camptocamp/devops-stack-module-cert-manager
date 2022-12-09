#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  description = "Principal default domain"
  type        = string
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

variable "app_autosync" {
  type    = bool
  default = true
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "main" # x-release-please-version
}
#######################
## Module variables
#######################
