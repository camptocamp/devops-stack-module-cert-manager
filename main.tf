resource "null_resource" "dependencies" {
  triggers = var.dependency_ids
}

resource "argocd_project" "this" {
  metadata {
    name      = "cert-manager"
    namespace = var.argocd_namespace
    annotations = {
      "devops-stack.io/argocd_namespace" = var.argocd_namespace
    }
  }

  spec {
    description  = "cert-manager application project"
    source_repos = ["https://github.com/camptocamp/devops-stack-module-cert-manager.git"]

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    destination {
      name      = "in-cluster"
      namespace = "kube-system"
    }

    orphaned_resources {
      warn = true
    }

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }
  }
}

data "utils_deep_merge_yaml" "values" {
  input       = [for i in concat(local.helm_values, var.helm_values) : yamlencode(i)]
  append_list = var.deep_merge_append_list
}

resource "argocd_application" "this" {
  metadata {
    name      = "cert-manager"
    namespace = var.argocd_namespace
  }

  wait = var.app_autosync == { "allow_empty" = tobool(null), "prune" = tobool(null), "self_heal" = tobool(null) } ? false : true

  spec {
    project = argocd_project.this.metadata.0.name

    source {
      repo_url        = "https://github.com/camptocamp/devops-stack-module-cert-manager.git"
      path            = "charts/cert-manager"
      target_revision = var.target_revision
      helm {
        values = data.utils_deep_merge_yaml.values.output
      }
    }

    destination {
      name      = "in-cluster"
      namespace = var.namespace
    }

    ignore_difference {
      group         = "admissionregistration.k8s.io"
      kind          = "ValidatingWebhookConfiguration"
      name          = "cert-manager-webhook"
      json_pointers = ["/webhooks/0/namespaceSelector/matchExpressions/2"]
    }

    sync_policy {
      automated {
        prune       = var.app_autosync.prune
        self_heal   = var.app_autosync.self_heal
        allow_empty = var.app_autosync.allow_empty
      }

      retry {
        backoff {
          duration     = "20s"
          max_duration = "2m"
          factor       = "2"
        }
        limit = "5"
      }

      sync_options = [
        "CreateNamespace=true"
      ]
    }
  }

  depends_on = [
    resource.null_resource.dependencies,
  ]
}

resource "null_resource" "this" {
  depends_on = [
    resource.argocd_application.this,
  ]
}
