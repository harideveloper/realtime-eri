output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${confluent_environment.env.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.cluster.id}
  Kafka topic name: ${confluent_kafka_topic.topic.topic_name}

  Service Accounts and their Kafka API Keys (API Keys inherit the permissions granted to the owner):
  ${confluent_service_account.admin-sa.display_name}:                         ${confluent_service_account.admin-sa.id}
  ${confluent_service_account.admin-sa.display_name}'s Kafka API Key:        "${confluent_api_key.admin-sa-api-key.id}"
  ${confluent_service_account.admin-sa.display_name}'s Kafka API Secret:     "${confluent_api_key.admin-sa-api-key.secret}"

  ${confluent_service_account.producer-sa.display_name}:                    ${confluent_service_account.producer-sa.id}
  ${confluent_service_account.producer-sa.display_name}'s Kafka API Key:    "${confluent_api_key.producer-sa-api-key.id}"
  ${confluent_service_account.producer-sa.display_name}'s Kafka API Secret: "${confluent_api_key.producer-sa-api-key.secret}"

  ${confluent_service_account.consumer-sa.display_name}:                    ${confluent_service_account.consumer-sa.id}
  ${confluent_service_account.consumer-sa.display_name}'s Kafka API Key:    "${confluent_api_key.consumer-sa-api-key.id}"
  ${confluent_service_account.consumer-sa.display_name}'s Kafka API Secret: "${confluent_api_key.consumer-sa-api-key.secret}"

  EOT

  sensitive = true
}
