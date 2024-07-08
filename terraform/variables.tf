variable "project_id" {
  description = "Project ID of your GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region you want to deploy to"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone you want to deploy to"
  type        = string
  default     = "us-central1-a"
}

variable "public_key_path" {
  description = "Path to the SSH pub key to use"
  type        = string
}

variable "sa_account_credentials" {
  description = "Path to SA Account JSON file credentials"
  type        = string
}