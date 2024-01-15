resource "azurerm_container_registry_task" "main" {
  name                  = "${var.category_name}-${var.image_name}"
  container_registry_id = var.container_registry_id
  platform {
    os = "Linux"
  }
  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = "${local.url}#${var.branch_name}:${var.folder_path}"
    context_access_token = var.pat_token
    image_names          = [
        "${var.category_name}/${var.image_name}:{{.Run.ID}}", 
        "${var.category_name}/${var.image_name}:latest"
    ]
  }

  source_trigger {
    name = var.repository_name
    events = [ "commit", "pullrequest" ]
    repository_url = local.url
    branch = var.branch_name
    source_type = "Github"
    authentication {
      token = var.pat_token
      token_type = "PAT"
    }
  }
}