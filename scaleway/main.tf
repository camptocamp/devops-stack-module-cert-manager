module "cert-manager" {
  source = "../self-signed/"

  argocd_namespace = var.argocd_namespace

  enable_service_monitor = var.enable_service_monitor

  namespace       = var.namespace
  target_revision = var.target_revision
  app_autosync    = var.app_autosync

  helm_values = concat(local.helm_values, var.helm_values)

  dependency_ids = var.dependency_ids
}
