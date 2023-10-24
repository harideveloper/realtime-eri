terraform {
  backend "gcs" {
    bucket         = "realtime-eri-tf-prod-state-bucket"
    prefix         = "terraform/state"
  }
}