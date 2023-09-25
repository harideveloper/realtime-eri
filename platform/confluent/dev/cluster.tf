// Basic Cluster
resource "confluent_kafka_cluster" "dev" {
  display_name = "${var.app}-${var.env}"
  availability = var.cluster_availability_mode
  cloud        = var.cloud_provider
  region       = var.cloud_region
  standard {}
  environment {
    id = confluent_environment.env.id
  }
}








