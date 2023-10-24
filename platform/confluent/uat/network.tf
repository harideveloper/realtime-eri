resource "confluent_network" "private-service-connect" {
  display_name     = "${var.app}-pvc" //"Private Service Connect Network"
  cloud            = var.cloud_provider
  region           = var.region
  connection_types = ["PRIVATELINK"]
  zones            = ["europe-west2-b"]
  environment {
    id = confluent_environment.env.id
  }
  dns_config {
    resolution = "PRIVATE"
  }
}

resource "confluent_private_link_access" "gcp" {
  display_name = "GCP Private Service Connect"
  gcp {
    project = var.consumer_project_id
  }
  environment {
    id = confluent_environment.env.id
  }
  network {
    id = confluent_network.private-service-connect.id
  }
}