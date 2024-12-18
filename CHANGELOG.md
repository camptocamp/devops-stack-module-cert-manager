# Changelog

## [10.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v9.0.2...v10.0.0) (2024-10-31)


### ⚠ BREAKING CHANGES

* **aks:** remove hardcoded resources and replicas

### Features

* add variable to set number of replicas ([fa0448e](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/fa0448e62a4f38d1fad05ec8d273b76c21fe62d4))
* **chart:** minor update of dependencies on cert-manager chart ([0164b7f](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/0164b7f5e6e9d6a45a8145d2f800bcca13ac6fd1))


### Bug Fixes

* **aks:** remove hardcoded resources and replicas ([3c9bcff](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/3c9bcff8c6956f2ef3f386173411717cf689f77e))
* remove unsupported values from the cert-manager field ([8ccf6aa](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/8ccf6aa146d5679688c9c2f0ea058870c0e3a558))

## [9.0.2](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v9.0.1...v9.0.2) (2024-10-23)


### Bug Fixes

* **dashboards:** add release in file name to avoid duplicates ([#103](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/103)) ([2b92b82](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2b92b8202df3eaabc561fa293a924e3e73fa946c))

## [9.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v9.0.0...v9.0.1) (2024-10-21)


### Bug Fixes

* grafana panels uses angular deprecated plugin ([#100](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/100)) ([675c012](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/675c012e224a886500a3d2321d73e0a546a6a2da))

## [9.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.6.0...v9.0.0) (2024-10-09)


### ⚠ BREAKING CHANGES

* point the Argo CD provider to the new repository ([#98](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/98))

### Features

* point the Argo CD provider to the new repository ([#98](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/98)) ([1129b32](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/1129b324caeeaedd24beb8cfb1bcf45e90efcdb6))

### Migrate provider source `oboukili` -> `argoproj-labs`

We've tested the procedure found [here](https://github.com/argoproj-labs/terraform-provider-argocd?tab=readme-ov-file#migrate-provider-source-oboukili---argoproj-labs) and we think the order of the steps is not exactly right. This is the procedure we recommend (**note that this should be run manually on your machine and not on a CI/CD workflow**):

1. First, make sure you are already using version 6.2.0 of the `oboukili/argocd` provider.

1. Then, check which modules you have that are using the `oboukili/argocd` provider.

```shell
$ terraform providers

Providers required by configuration:
.
├── provider[registry.terraform.io/hashicorp/helm] 2.15.0
├── (...)
└── provider[registry.terraform.io/oboukili/argocd] 6.2.0

Providers required by state:

    (...)

    provider[registry.terraform.io/oboukili/argocd]

    provider[registry.terraform.io/hashicorp/helm]
```

3. Afterwards, proceed to point **ALL*  the DevOps Stack modules to the versions that have changed the source on their respective requirements. In case you have other personal modules that also declare `oboukili/argocd` as a requirement, you will also need to update them.

4. Also update the required providers on your root module. If you've followed our examples, you should find that configuration on the `terraform.tf` file in the root folder.

5. Execute the migration  via `terraform state replace-provider`:

```bash
$ terraform state replace-provider registry.terraform.io/oboukili/argocd registry.terraform.io/argoproj-labs/argocd
Terraform will perform the following actions:

  ~ Updating provider:
    - registry.terraform.io/oboukili/argocd
    + registry.terraform.io/argoproj-labs/argocd

Changing 13 resources:

  module.argocd_bootstrap.argocd_project.devops_stack_applications
  module.secrets.module.secrets.argocd_application.this
  module.metrics-server.argocd_application.this
  module.efs.argocd_application.this
  module.loki-stack.module.loki-stack.argocd_application.this
  module.thanos.module.thanos.argocd_application.this
  module.cert-manager.module.cert-manager.argocd_application.this
  module.kube-prometheus-stack.module.kube-prometheus-stack.argocd_application.this
  module.argocd.argocd_application.this
  module.traefik.module.traefik.module.traefik.argocd_application.this
  module.ebs.argocd_application.this
  module.helloworld_apps.argocd_application.this
  module.helloworld_apps.argocd_project.this

Do you want to make these changes?
Only 'yes' will be accepted to continue.

Enter a value: yes

Successfully replaced provider for 13 resources.
```

6. Perform a `terraform init -upgrade` to upgrade your local `.terraform` folder.

7. Run a `terraform plan` or `terraform apply` and you should see that everything is OK and that no changes are necessary. 

## [8.6.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.5.0...v8.6.0) (2024-08-20)


### Features

* **chart:** patch update of dependencies on cert-manager chart ([#95](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/95)) ([302049d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/302049df5911758a7b7d566147c99cad8ff79fb0))

## [8.5.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.4.0...v8.5.0) (2024-08-15)


### Features

* **chart:** patch update of dependencies on cert-manager chart ([#93](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/93)) ([4feb103](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/4feb103e443f901cfa694b3c4e76ec4a6c01ca48))

## [8.4.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.3.0...v8.4.0) (2024-07-10)


### Features

* **chart:** patch update of dependencies on cert-manager chart ([#91](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/91)) ([cdb728f](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/cdb728f5bc46c888e83d4e0c89d0a7d95f43075e))

## [8.3.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.2.0...v8.3.0) (2024-06-07)


### Features

* **chart:** minor update of dependencies on cert-manager chart ([#89](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/89)) ([9691a2d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/9691a2d6234a7855040e77d32214330d2d0759d0))

## [8.2.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.1.0...v8.2.0) (2024-04-16)


### Features

* add variable to set resources with default values ([#87](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/87)) ([a7a4c6d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a7a4c6daaa69cceecb490bcf8a9ff08bda0d2bfa))

## [8.1.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v8.0.0...v8.1.0) (2024-03-01)


### Features

* **chart:** minor update of dependencies on cert-manager chart ([#83](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/83)) ([37f9e27](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/37f9e270e4c07c928407785fcc94245f5ea16bed))
* make the dashboard deployment dynamic ([5e6d66e](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/5e6d66e68e6e8115970fb60008a76c203b08ced8))

## [8.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v7.0.1...v8.0.0) (2024-01-19)


### ⚠ BREAKING CHANGES

* remove the ArgoCD namespace variable
* remove the namespace variable
* hardcode the release name to remove the destination cluster

### Features

* add default rules to alert for expiring certificates ([#82](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/82)) ([d02a4e9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d02a4e9c5e090298f5c44cfa3491a9c2c1a90b9f))
* **chart:** patch update of dependencies on cert-manager chart ([#79](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/79)) ([c086887](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/c086887cd96e153bafd166fb9931d5382651039b))


### Bug Fixes

* **aks:** fix resource group dependency ([9ecfa4c](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/9ecfa4c079d238eef410259885d4f455a77204da))
* **aks:** remove image tag because chart has been upgraded ([56d78db](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/56d78db18ce7de18f2cf4806b45ed496de01b710))
* hardcode the release name to remove the destination cluster ([210d3ad](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/210d3ad5066cc342fd20d48c66ae58f3d9286492))
* remove the ArgoCD namespace variable ([b540733](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b54073381a7f115ff949fec122c2d2b61d320476))
* remove the namespace variable ([728f40a](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/728f40a12d4cb52fb80e65e37ab33f89df54b081))

## [7.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v7.0.0...v7.0.1) (2023-11-10)


### Bug Fixes

* remove the need to set the Let's Encrypt e-mail when self-signed ([#77](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/77)) ([93efa4f](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/93efa4f1c2f4fa391cf87b0608388955573fc290))

## [7.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v6.0.0...v7.0.0) (2023-11-10)


### ⚠ BREAKING CHANGES

* remove our company mail from the Let's Encrypt issuer - we removed the e-mail that was hardcoded and added a new variable, called `letsencrypt_issuer_email`, that has no default value and is absolutely **required** on the module instantiation.

### Features

* define ca and default issuers on locals and transmit to chart ([563d385](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/563d3854463683da28831eb58addca54069d56da))
* use loop to build issuers values and output them ([2e1f7c8](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2e1f7c8445e9b06e2f7c7ebbb7888b89023ffbfd))


### Bug Fixes

* remove our company mail from the Let's Encrypt issuer ([16b297d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/16b297ddb6ebc30af5ab7f8f2ffd2d15f7ad690a))

## [6.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.3.0...v6.0.0) (2023-11-02)


### ⚠ BREAKING CHANGES

* **chart:** minor update of dependencies on cert-manager chart ([#67](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/67)): 

  - [v1.13.0](https://github.com/cert-manager/cert-manager/releases/tag/v1.13.0) - this version introduced a potential breaking change; although these changes do not affect our module's code directly, please note that **if someone is overloading the `helm_values` variable and has set the `.featureGates value, they could be affected by this release**.

### Features

* **chart:** minor update of dependencies on cert-manager chart ([#67](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/67)) ([3a97637](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/3a97637c69882380da75407118e502ea497dbb5d))

## [5.3.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.2.1...v5.3.0) (2023-10-19)


### Features

* add standard variables and variable to add labels to Argo CD app ([d91c418](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d91c418d3c9056c16c407f3f38dd3a0f71ecb222))
* add variables to set AppProject and destination cluster ([54ea559](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/54ea559cf6f354a2b601e78d58ad76ed5b042240))


### Bug Fixes

* **aks:** fix the webhook ignore_differences to use new naming scheme ([a7dd9da](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a7dd9dac438bce17535f2f46bce5352199ecd16e))

## [5.2.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.2.0...v5.2.1) (2023-10-03)


### Bug Fixes

* **argocd-app:** webhook issue ([#69](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/69)) ([77561d7](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/77561d73c6ddddf0e27c6d0c7ffcef97e90d4006))

## [5.2.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.1.0...v5.2.0) (2023-09-07)


### Features

* **chart:** patch update of dependencies on cert-manager chart ([#65](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/65)) ([b1db8f4](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b1db8f4db670e73677bdc87d9c0e57c374d8038a))

## [5.1.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.0.1...v5.1.0) (2023-08-10)


### Features

* **chart:** minor update of dependencies on cert-manager chart ([#63](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/63)) ([25cf8b0](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/25cf8b0eda52c17269046b82eb91d45a1fa22f72))

## [5.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v5.0.0...v5.0.1) (2023-08-09)


### Bug Fixes

* readd support to deactivate auto-sync which was broken by [#59](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/59) ([d412334](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d412334ab0e1f7d6903d2b0a348e4f3c0dd26d20))

## [5.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v4.0.3...v5.0.0) (2023-07-11)


### ⚠ BREAKING CHANGES

* add support to oboukili/argocd v5 ([#59](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/59))

### Features

* add support to oboukili/argocd v5 ([#59](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/59)) ([dc00ece](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/dc00ecea08222492d8777f98eef38971595a4fe7))

## [4.0.3](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v4.0.2...v4.0.3) (2023-06-16)


### Documentation

* fix the collapsible table and correct links on README.adoc ([#57](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/57)) ([ddc8e37](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/ddc8e37670d478b2189a375a016bb2e51dfbb63c))

## [4.0.2](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v4.0.1...v4.0.2) (2023-06-05)


### Bug Fixes

* add missing provider ([a33a168](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a33a1683e0542fc5d2e72d8ec40bf2b12e0a1536))

## [4.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v4.0.0...v4.0.1) (2023-05-30)


### Bug Fixes

* use main module instead of the self-signed one ([#54](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/54)) ([d0d7297](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d0d7297bb1260016753ee4bbc4ddf3c581bee8ac))

## [4.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v3.1.0...v4.0.0) (2023-05-24)


### ⚠ BREAKING CHANGES

* **sks:** remove nodeAffinity config for SKS clusters ([#51](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/51))

### Bug Fixes

* **sks:** remove nodeAffinity config for SKS clusters ([#51](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/51)) ([2805c68](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2805c688d626cee32a53a2dba0424e754999aeb3))

## [3.1.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v3.0.0...v3.1.0) (2023-05-17)


### Features

* **chart:** upgrade chart to v1.11.2 ([0db0ea6](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/0db0ea60af96a4175737eca7255ca3a156198bd8))


### Bug Fixes

* point id to the right id and add description to outputs ([2f59926](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2f599261dcf3c88334c6f278141dd801fb428749))
* remove global variables and limit scope to required variants ([02125d6](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/02125d6b3066aae5b9ba5a198cbfb391dd14274f))

## [3.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v2.0.1...v3.0.0) (2023-05-15)


### ⚠ BREAKING CHANGES

* remove ServiceMonitor CRD ([#46](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/46))

### Features

* remove ServiceMonitor CRD ([#46](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/46)) ([e056c68](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/e056c6898465f0db584eb792a7ad69306a37d401))

## [2.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v2.0.0...v2.0.1) (2023-05-09)


### Bug Fixes

* **eks:** iam policies for DNS validation with multiple domains ([#45](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/45)) ([2abbccc](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2abbccc37fb8e0726f89253c199aee4733cdc9cd))

## [2.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.1...v2.0.0) (2023-04-13)


### ⚠ BREAKING CHANGES

* **azure:** replace pod identity with workload identity ([#42](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/42))

### Features

* **azure:** replace pod identity with workload identity ([#42](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/42)) ([16ac840](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/16ac840ae778697b56b18744a1ba7c8e23cbab40))

## [1.0.1](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0...v1.0.1) (2023-04-03)


### Documentation

* remove orphaned symbolic link ([#40](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/40)) ([b56afc9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b56afc9092bb932aacfb26c7355bf16f6fa561ea))

## [1.0.0](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.6...v1.0.0) (2023-03-28)


### ⚠ BREAKING CHANGES

* this commit reintroduces the http01 solver by default.

### Features

* add variables for solvers configurations ([#38](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/38)) ([cae70c8](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/cae70c808f5a2d6e9908f122057e592f2af25e05))

## [1.0.0-alpha.6](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.5...v1.0.0-alpha.6) (2023-02-01)


### Features

* enable deep merge of http01 and dns01 as list (opt-in using variable) ([448b762](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/448b76296fe3189551a0185074b6d1e973c47f9e))


### Miscellaneous Chores

* release 1.0.0-alpha.6 ([#35](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/35)) ([814fd9b](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/814fd9bcb7d3641a9ee9b24d4ce40b6d6426facc))

## [1.0.0-alpha.5](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.4...v1.0.0-alpha.5) (2023-01-30)


### Features

* **aks:** increase default memory resources ([#27](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/27)) ([029559a](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/029559ad2f9ec20c8e66d1f8c4bc6e60c4256da6))
* **helm:** bump version to 1.11 ([#28](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/28)) ([ca4765a](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/ca4765a2d98e193ec9a07280332cc7356d39c01a))


### Miscellaneous Chores

* release 1.0.0-alpha.5 ([#33](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/33)) ([f305df7](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/f305df76bf1fdeac76d9a3939ec35c0e595ce5ba))

## [1.0.0-alpha.4](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.3...v1.0.0-alpha.4) (2023-01-30)


### Features

* **wait:** add dependency to var app_autosync ([#26](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/26)) ([b346753](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b3467537c79e4b3ee3812a24365f706b7675c8f1))

## [1.0.0-alpha.3](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.2...v1.0.0-alpha.3) (2022-12-16)


### Features

* add variable to configure auto-sync of the Argo CD Application ([#24](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/24)) ([f533057](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/f533057062679389499a60a7061f929bf8469c41))

## [1.0.0-alpha.2](https://github.com/camptocamp/devops-stack-module-cert-manager/compare/v1.0.0-alpha.1...1.0.0-alpha.2) (2022-12-01)


### Bug Fixes

* **aks:** homogenize rg naming convention between modules ([ca60f8f](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/ca60f8fb8cc84047276593737fb912146eee8f10))

## 1.0.0-alpha.1 (2022-11-18)


### ⚠ BREAKING CHANGES

* move Terraform module at repository root
* rename helm_values_overrides as helm_values
* pass hcl values and rename to helm_values_overrides
* use var.cluster_info

### Features

* add k3s profile ([1e498d9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/1e498d993f057148d3b5d3a015704458996f73c9))
* add role assignment DNS zone contributor ([d9fa4ce](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d9fa4ce77fbe29070490180556fde6bb1f6d2dd1))
* add service monitor to solve monitoring module dependency ([b55797c](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b55797c192c395d376aa790a77cb506635b5b17b))
* add sks support ([eb70e89](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/eb70e89ca09a0ab479e6cee8f2111302c79aceea))
* add support of scaleway ([#16](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/16)) ([2c82a46](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2c82a46676cb3ffe7945dee7f64e1c1948f3f7d4))
* **aks:** add aks support ([eaefcd0](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/eaefcd07ebb5f59b5235ce930e22d8fa7957f232))
* **eks:** allow multiple domains ([#14](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/14)) ([4e0a4fe](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/4e0a4fe23518f3f5a918f5bc5551ed4cd09af802))
* pass hcl values and rename to helm_values_overrides ([d2334a9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d2334a93d53ec10264a6f22409d73cb8914b1848))
* rename helm_values_overrides as helm_values ([1f027eb](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/1f027eb43521c5c24f196a857efbecd8dfbe3ea6))


### Bug Fixes

* **aks:** add missing resource_group_name variable ([a84ded5](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a84ded57b64d87d84bf16a4f16d85aa6fa9a03ed))
* **aks:** sym link to version.tf so providers get declared ([0669ef9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/0669ef9e3f97a502dc60366c92e207ecf5c1ad7a))
* allow kube-system in project ([a723ffe](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a723ffe4784d340b24c3a977642a0e4feeeddbb2))
* argocd_namespace ([7d4ba0e](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/7d4ba0e6f106e14ce20b8050606242c5826fa567))
* **azure:** field name azuredns becomes azureDNS in ClusterIssuer CRD ([d71c0c2](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/d71c0c2c3c28d517e86357eb1a4a47fc0b2f64cb))
* contains(profiles, "eks") ([03866a8](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/03866a81d6955dbc36ebe6415229682cd9305aa6))
* default namespace is cert-manager ([f472ad7](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/f472ad7fc6ab8177f4819ec69814fa7f27c05964))
* do not delay Helm values evaluation ([e335f07](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/e335f0730c304472e08eb34faca4f8b6da12fa80))
* **eks:** rename values.yaml to value.tmpl.yaml ([1be158d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/1be158d93fda5680214de5658884d76391967f61))
* **helm:** use non-deprecated CRD version for cluster issuers ([0f31a9b](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/0f31a9bdeefcbc397fdb7fbbe4c1b3d2c25cca33))
* ignore validating webhook changes ([19b8ab5](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/19b8ab58e265df3342b2e103cfe4d25b6f24bf1f))
* json_pointers parameter name ([7d8630f](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/7d8630f632971f8f6cdbaed7e6aebceb857c07c0))
* name of the ignored field ([bd5af14](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/bd5af14e5c5b1bac7532c35a8649459a61277b37))
* pass cluster_oid_issuer_url in var.cert-manager ([13276a9](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/13276a9ed524234807d0a97a602ecd9977944ca2))
* pass variables to eks module ([923fa31](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/923fa31c9c65455ff02b0dc1e95e619d2d22543e))
* README ([2f07d30](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2f07d30e2d61702cd7bb74f86423c07775a27e30))
* remove cluster_id var from eks module ([fa7c785](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/fa7c785195498c325faa3a839005b1b90a08069a))
* remove legacy cert-manager variable in template ([979cf96](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/979cf9667f280757dd31b4afba66938c3d9a261f))
* remove profiles from aks and eks submodules ([64ee182](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/64ee18286c5137c6bdc53ba619450cf09f6d0b4a))
* remove read only attribut ([#17](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/17)) ([52742d4](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/52742d436868f320b695c53e35a4c55631290281))
* retry policy ([fa70404](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/fa70404b45ffa746128e8f31f87efa4e39bad9a4))
* rework eks module ([e8ceb3d](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/e8ceb3d39023f60a5f8b7262e080f1b4edf0cc43))
* **self-signed:** typo in helm parameter tlsCrt ([68e8cad](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/68e8cad3df8aa83e4008df58e986ab8a7d26c1a5))
* **self-signed:** use private key instead of certificate for tlsKey ([a376d88](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/a376d88fb31a1f23fa61ea7a30d7858ed3b7e92e))
* **sks:** helm_values syntax issue ([#15](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/15)) ([b1ef19a](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/b1ef19a35057afb29e857c1fb86dda041240f443))
* sync policy ([c3a9e92](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/c3a9e9252f171d4041105fb730e7b172414a2694))
* use underscore ([48e20ba](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/48e20bae032d85e33637ab55a86cdf226824f49f))
* wait for app removel before deleting the project ([6479e86](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/6479e863b61d3b615a143315d0b3917bc03a2525))
* work around argocd terraform provider default values ([829b85c](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/829b85c45da46035cfdd70836ee6082b65542587))


### Code Refactoring

* move Terraform module at repository root ([2a1805b](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/2a1805b076fe0e1f9764cfc65b5b493dd4af32a6))
* use var.cluster_info ([9d1cc27](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/9d1cc276b9d92ace11939a8ba2a620d7263ca985))


### Continuous Integration

* add central workflows including release-please ([#20](https://github.com/camptocamp/devops-stack-module-cert-manager/issues/20)) ([e7fc334](https://github.com/camptocamp/devops-stack-module-cert-manager/commit/e7fc334afcd3ddabba4bc07a93257c39fa3f1ce0))
