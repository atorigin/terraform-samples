variable "gitlab_api_token" {}
variable "gitlab_host_url" {}

variable "common_backend_ci" {
  type        = string
  default     = "backend-pipeline.yml@devops/pipelines"
  description = "一般使用場景的 backend 專案 gitlab-ci yaml 檔"
}
