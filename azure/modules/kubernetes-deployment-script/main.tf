resource "azurerm_kubernetes_cluster_extension" "flux" {
  name           = "flux"
  cluster_id     = var.cluster_id
  extension_type = "microsoft.flux"
}
/*
resource "azurerm_kubernetes_flux_configuration" "certmanager" {
  name       = "cert-manager"
  cluster_id = var.cluster_id
  namespace  = "cert-manager"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-certmanager.git"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "sources"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources"
  }

  kustomizations {
    name = var.environment_name
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "clusters/${var.environment_name}"
    depends_on = [ "sources" ]
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}

resource "azurerm_kubernetes_flux_configuration" "keda" {
  name       = "keda"
  cluster_id = var.cluster_id
  namespace  = "keda"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-keda"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "keda"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}



resource "azurerm_kubernetes_flux_configuration" "nginx" {
  name       = "nginx"
  cluster_id = var.cluster_id
  namespace  = "nginx"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-nginx"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "nginx"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 900
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}



resource "azurerm_kubernetes_flux_configuration" "prefect_server" {
  name       = "prefect-server"
  cluster_id = var.cluster_id
  namespace  = "prefect"
  scope = "namespace"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-prefect-server"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "cluster-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "cluster/${var.environment_name}"
  }

  kustomizations {
    name = "sources"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources"

    depends_on = [ "cluster-config" ]
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}



resource "azurerm_kubernetes_flux_configuration" "jupyterhub" {
  name       = "jupyterhub"
  cluster_id = var.cluster_id
  namespace  = "jupyterhub"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-jupyter"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "cluster-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "cluster/${var.environment_name}"
  }

  kustomizations {
    name = "shared-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources/config"

    depends_on = [ "cluster-config" ]
  }


  kustomizations {
    name = "package"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources/package"

    depends_on = [ "shared-config" ]
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}



resource "azurerm_kubernetes_flux_configuration" "github_runner" {
  count = var.enable_gitops ? 1 : 0
  name       = "github-runner"
  cluster_id = var.cluster_id
  namespace  = "github-runner"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-github-action-runners"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "cluster-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "cluster/${var.environment_name}"
  }

  kustomizations {
    name = "sources"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources"

    depends_on = [ "cluster-config" ]
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}

## https://github.com/lsc-sde/iac-flux-keycloak



resource "azurerm_kubernetes_flux_configuration" "keycloak" {
  name       = "keycloak"
  cluster_id = var.cluster_id
  namespace  = "keycloak"
  scope = "cluster"

  git_repository {
    url             = "https://github.com/lsc-sde/iac-flux-keycloak"
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }

  kustomizations {
    name = "sources"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "sources"

  }

  kustomizations {
    name = "cluster-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "cluster/${var.environment_name}"

    depends_on = [ "sources" ]
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}

*/

resource "azurerm_kubernetes_flux_configuration" "lscsde" {
  name       = "lscsde"
  cluster_id = var.cluster_id
  namespace  = "lscsde"
  scope = "cluster"

  git_repository {
    url             = var.flux_url
    reference_type  = "branch"
    reference_value = var.branch_name
    sync_interval_in_seconds = 60
    timeout_in_seconds = 600
  }
  kustomizations {
    name = "cluster-config"
    sync_interval_in_seconds = 60
    retry_interval_in_seconds = 60
    timeout_in_seconds = 600
    path = "clusters/${var.environment_name}"
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]
}