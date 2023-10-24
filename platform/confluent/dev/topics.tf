resource "confluent_kafka_topic" "topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-topic"
  partitions_count = 2
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}

// Spike 1
resource "confluent_kafka_topic" "topic-spike1" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-spike1"
  partitions_count = 3
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}

// Spike 2
resource "confluent_kafka_topic" "topic-spike2" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-spike2"
  partitions_count = 3
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}

// Spike 3
resource "confluent_kafka_topic" "topic-spike3" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-spike3"
  partitions_count = 3
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}

// Spike 4
resource "confluent_kafka_topic" "topic-spike4" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "${var.app}-${var.env}-spike4"
  partitions_count = 2
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}


// Keda Spike
resource "confluent_kafka_topic" "topic-spike-keda" {
  kafka_cluster {
    id = confluent_kafka_cluster.dev.id
  }
  topic_name       = "keda-${var.app}-${var.env}-spike"
  partitions_count = 10
  rest_endpoint    = confluent_kafka_cluster.dev.rest_endpoint
  credentials {
    key    = confluent_api_key.admin-sa-api-key.id
    secret = confluent_api_key.admin-sa-api-key.secret
  }
}
