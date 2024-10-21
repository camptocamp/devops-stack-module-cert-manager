locals {
  default_solvers = {
    http01 = {
      http01 = {
        ingress = {}
      }
    }
  }

  use_default_solvers = {
    http01 = var.use_default_http01_solver
  }

  solvers = concat(
    [for each in ["http01"] : local.default_solvers[each] if local.use_default_solvers[each]],
    var.custom_solver_configurations
  )

  helm_values = [{
    cert-manager = {}

    # This structure will be merged with the one with the same name on the root locals.tf.
    clusterIssuers = {
      letsencrypt = {
        enabled = true
        acme = {
          solvers = local.solvers
        }
      }
    }
  }]
}
