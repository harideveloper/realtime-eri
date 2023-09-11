

// KAFKA CLUSTER

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





