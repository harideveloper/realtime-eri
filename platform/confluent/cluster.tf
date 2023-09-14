


// Basic Cluster
resource "confluent_kafka_cluster" "cluster" {
  display_name = var.app
  availability = var.cluster_availability_mode
  cloud        = var.cloud_provider
  region       = var.cloud_region
  standard {}
  environment {
    id = confluent_environment.env.id
  }
}


// Dedicated Cluster
resource "confluent_kafka_cluster" "dedicated" {
  display_name = "${var.app}-dedicated"
  availability = "SINGLE_ZONE"
  cloud        = confluent_network.confluent_vpc.cloud
  region       = confluent_network.confluent_vpc.region
  dedicated {
    cku = 1
  }
  environment {
    id = confluent_environment.env.id
  }
  network {
    id = confluent_network.confluent_vpc.id
  }
}






