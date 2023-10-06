resource "confluent_kafka_topic" "topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-topic"
  //partitions_count = 2
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}


// Additional Topic

resource "confluent_kafka_topic" "topic1" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-test-topic"
  partitions_count = 3
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}
