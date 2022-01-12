# devops-stack-module-cert-manager


## Usage

```hcl
module "cert-manager" {
  source = "git::https://github.com/camptocamp/devops-stack-module-cert-manager.git//modules/self-signed"

  cluster_name   = var.cluster_name
  oidc           = module.cluster.oidc
  argocd         = {
    namespace = module.cluster.argocd_namespace
  }
  base_domain    = module.cluster.base_domain
  cluster_issuer = "ca-issuer"
}
```

## Submodules

### Default

- Description: Simple installation and configuration of Cert-Manager.
- Source: `git::https://github.com/camptocamp/devops-stack-module-cert-manager.git//modules`


### Self Signed

- Description: Adds a key pair and sets it up for the CA issuer.
- Source: `git::https://github.com/camptocamp/devops-stack-module-cert-manager.git//modules/self-signed`


### EKS

- Description: Adds IAM roles and policies to give Cert-Manager write access to
  Route53 in order to perform DNS-01 challenges.
- Source: `git::https://github.com/camptocamp/devops-stack-module-cert-manager.git//modules/eks`
- Extra variables:
   - `cluster_oidc_issuer_url`, to be passed from the EKS cluster module
