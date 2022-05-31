locals {
  assumable_role_arn = var.base_domain == null ? "" : module.iam_assumable_role_cert_manager.0.iam_role_arn

  helm_values = [{
    cert-manager = {
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = local.assumable_role_arn
        }
      }
      clusterIssuers = {
        letsencrypt = {
          enabled = true
        }
        acme = {
          solvers = [
            {
              dns01 = {
                route53 = {
                  region = data.aws_region.current.name
                }
              }
              selector = {
                dnsZones = [for domain in var.all_domains : domain]
              }
            },
            {
              http01 = {
                ingress = {}
              }
            },
          ]
        }
      }
    }
  }]
}
