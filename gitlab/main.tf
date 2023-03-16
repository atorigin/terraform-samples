provider "gitlab" {
    base_url = var.gitlab_host_url
    token = var.gitlab_api_token
}

# Add a group
resource "gitlab_group" "sample_group" {
  name        = "example"
  path        = "example"
  description = "An example group"
  visibility_level = "private"
  subgroup_creation_level = "owner"
  auto_devops_enabled = "false"
}

# Add a project to the group - example/example
resource "gitlab_project" "sample_group_project" {
  name         = "example"
  namespace_id = gitlab_group.sample_group.id
  ci_config_path = var.common_backend_ci
}
