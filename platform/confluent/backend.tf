terraform {
  backend "gcs" {
    bucket         = "realtime-eri-confluent-tf"
    prefix         = "terraform/state"
  }
}