variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "region" {
  description = "region location of the project"
  type        = string
}

variable "zone" {
  description = "zone location of the project"
  type        = string
}

variable "terraform_service_account_id" {
  type        = string
  description = "Account ID for the service account used by GitHub Actions"
}

variable "github_username" {
  type        = string
  description = "GitHub user name"
}

variable "github_repository" {
  type        = string
  description = "GitHub repository name"
}