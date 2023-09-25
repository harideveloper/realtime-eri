
// Confluent Features such as Schema Registry, Ksql, Stream Lineage , etc

// Schema Registry
resource "confluent_schema_registry_cluster" "essentials" {
  package = var.schema_registry_package
  environment {
    id = confluent_environment.env.id
  }
  region {
    id = var.schema_registry_package_id
  }
}
