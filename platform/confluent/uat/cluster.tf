

// Dedicated Cluster
resource "confluent_kafka_cluster" "uat" {
  display_name = "${var.app}-${var.env}"
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






