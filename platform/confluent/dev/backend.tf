terraform {
  backend "gcs" {
    bucket         = "realtime-eri-tf-dev-state-bucket"
    prefix         = "terraform/state"
  }
}