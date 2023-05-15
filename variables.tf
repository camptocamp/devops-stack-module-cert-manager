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

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "v3.0.0" # x-release-please-version
}

variable "namespace" {
  type    = string
  default = "cert-manager"
}

variable "use_default_dns01_solver" {
  description = "Whether to use the default dns01 solver configuration."
  type        = bool
  default     = true
}

variable "use_default_http01_solver" {
  description = "Whether to use the default http01 solver configuration."
  type        = bool
  default     = true
}

variable "custom_solver_configurations" {
  description = "List of additional solver configurations, appended to the default dns01 and http01 solvers (if enabled)."
  type        = list(any)
  default     = []
}

variable "enable_service_monitor" {
  description = "Enable Prometheus ServiceMonitor in the Helm chart."
  type        = bool
  default     = true
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
  description = "Automated sync options for the Argo CD Application resource."
  type = object({
    allow_empty = optional(bool)
    prune       = optional(bool)
    self_heal   = optional(bool)
  })
  default = {
    allow_empty = false
    prune       = true
    self_heal   = true
  }
}

variable "deep_merge_append_list" {
  description = "A boolean flag to enable/disable appending lists instead of overwriting them."
  type        = bool
  default     = false
}

#######################
## Module variables
#######################
