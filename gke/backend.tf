terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.42.0"
    }
  }

  backend "gcs" {
    bucket = "backend-terraform-cicd"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "advance-replica-428411-v0"
  region  = "us-east1"  
}
