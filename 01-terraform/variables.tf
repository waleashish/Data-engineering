variable "project" {
  description = "Data Engineering Zoomcamp"
  default     = "terraform-starter-417423"
}

variable "region" {
  description = "Project Region"
  default     = "us-central1"
}

variable "credentials" {
  description = "Login credentials"
  default     = "./keys/credentials.json"
}

variable "bucket-1-name" {
  description = "The storage bucket 1"
  default     = "terraform-starter-417423-bucket-1"
}

variable "bucket-1-location" {
  description = "Location of bucket 1"
  default     = "US"
}

variable "bigquery-dataset-id" {
  description = "Dataset ID"
  default     = "bigquery_dataset1"
}

variable "dataset-table-1-id" {
  description = "Table 1 ID"
  default     = "sheet"
}