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
    [ for each in ["http01"] : local.default_solvers[each] if local.use_default_solvers[each] ],
    var.custom_solver_configurations
  )

  helm_values = [{
    cert-manager = {
      clusterIssuers = {
        letsencrypt = {
          enabled = true
        }
        acme = {
          solvers = local.solvers
        }
      }
      affinity = {
        nodeAffinity = {
          preferredDuringSchedulingIgnoredDuringExecution = [
            {
              weight = 100
              preference = {
                matchExpressions = [
                  {
                    key      = "node.exoscale.net/nodepool-id"
                    operator = "NotIn"
                    values   = [var.router_pool_id]
                  }
                ]
              }
            }
          ]
        }
      }
      cainjector = {
        affinity = {
          nodeAffinity = {
            preferredDuringSchedulingIgnoredDuringExecution = [
              {
                weight = 100
                preference = {
                  matchExpressions = [
                    {
                      key      = "node.exoscale.net/nodepool-id"
                      operator = "NotIn"
                      values   = [var.router_pool_id]
                    }
                  ]
                }
              }
            ]
          }
        }
      }
      webhook = {
        affinity = {
          nodeAffinity = {
            preferredDuringSchedulingIgnoredDuringExecution = [
              {
                weight = 100
                preference = {
                  matchExpressions = [
                    {
                      key      = "node.exoscale.net/nodepool-id"
                      operator = "NotIn"
                      values   = [var.router_pool_id]
                    }
                  ]
                }
              }
            ]
          }
        }
      }
    }
  }]
}
