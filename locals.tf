locals {
  issuers = {
    letsencrypt = {
      production = {
        name   = "letsencrypt-prod"
        email  = "letsencrypt@camptocamp.com"
        server = "https://acme-v02.api.letsencrypt.org/directory"
      }
      staging = {
        name   = "letsencrypt-staging"
        email  = "letsencrypt@camptocamp.com"
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
      }
    }
  }

  helm_values = [{
    cert-manager = {
      installCRDs = true
      securityContext = {
        fsGroup = 999
      }
      prometheus = {
        servicemonitor = {
          enabled = var.enable_service_monitor
        }
      }
    }
    letsencrypt = {
      issuers = { for issuer_id, issuer in local.issuers.letsencrypt :
        issuer.name => {
          email  = issuer.email
          server = issuer.server
        }
      }
    }
  }]
}
