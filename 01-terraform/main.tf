terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.20.0"
    }
  }
}

provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "bucket-1" {
  name          = var.bucket-1-name
  location      = var.bucket-1-location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = var.bigquery-dataset-id
  friendly_name               = "Terraform basics bigquery dataset"
  description                 = "This is a test description"
  location                    = "US"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "bigquery_sheet" {
  dataset_id          = google_bigquery_dataset.default.dataset_id
  table_id            = var.dataset-table-1-id
  deletion_protection = false


  external_data_configuration {
    autodetect    = true
    source_format = "GOOGLE_SHEETS"

    source_uris = [
      "https://docs.google.com/spreadsheets/d/1bfSzi8jf3oovjv0IOZLXBgc33Pp22m0rl4TEJVx3XY0/edit?usp=sharing",
    ]
  }
}