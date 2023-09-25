// Network Settings

resource "confluent_network" "confluent_vpc" {
  display_name     = "${var.app}-confluent"
  cloud            = var.cloud_provider
  region           = var.cloud_region
  cidr             = var.confluent_cidr
  connection_types = ["PEERING"]
  environment {
    id = confluent_environment.env.id
  }
}

resource "confluent_peering" "confluent_to_gke" {
  display_name = "${var.app}-confluent_to_gke_peering"
  gcp {
    project              = var.consumer_project_id
    vpc_network          = var.consumer_vpc
    import_custom_routes = var.import_custom_routes
  }
  environment {
    id = confluent_environment.env.id
  }
  network {
    id = confluent_network.confluent_vpc.id
  }
}



# resource "google_compute_network_peering" "peering" {
#   name         = "${var.app}-confluent-peering"
#   network      = "projects/${var.consumer_project_id}/global/networks/${var.consumer_vpc}"
#   peer_network = "projects/${confluent_network.confluent_vpc.gcp[0].project}/global/networks/${confluent_network.confluent_vpc.gcp[0].vpc_network}"
# }
