
// IAM & Service Accounts


// KAFKA ADMIN
// 'admin-sa' service account is setup to create topics/partition and assign roles producer & consumer service accounts

resource "confluent_service_account" "admin-sa" {
  display_name = var.admin-sa
  description  = var.admin-sa-desc
}

resource "confluent_role_binding" "admin-sa-clusteradmin-rb" {
  principal   = "User:${confluent_service_account.admin-sa.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.cluster.rbac_crn
}

// Admin Account API Keys (Account Admin)
resource "confluent_api_key" "admin-sa-api-key" {
  display_name = var.admin-api-key-name
  description  = var.admin-api-key-desc
  owner {
    id          = confluent_service_account.admin-sa.id
    api_version = confluent_service_account.admin-sa.api_version
    kind        = confluent_service_account.admin-sa.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster.id
    api_version = confluent_kafka_cluster.cluster.api_version
    kind        = confluent_kafka_cluster.cluster.kind

    environment {
      id = confluent_environment.env.id
    }
  }

  depends_on = [
    confluent_role_binding.admin-sa-clusteradmin-rb
  ]
}

// CONSUMER

// Consumer Service Account
resource "confluent_service_account" "consumer-sa" {
  display_name = var.consumer-sa
  description  = var.consumer-sa-desc
}

resource "confluent_api_key" "consumer-sa-api-key" {
  display_name = var.consumer-api-key-name
  description  = var.consumer-api-key-desc
  owner {
    id          = confluent_service_account.consumer-sa.id
    api_version = confluent_service_account.consumer-sa.api_version
    kind        = confluent_service_account.consumer-sa.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster.id
    api_version = confluent_kafka_cluster.cluster.api_version
    kind        = confluent_kafka_cluster.cluster.kind

    environment {
      id = confluent_environment.env.id
    }
  }
}

// Consumer requires auth to perform 'READ' operation on both respective topic 
resource "confluent_role_binding" "consumer-developer-read-from-topic-rb" {
  principal   = "User:${confluent_service_account.consumer-sa.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${confluent_kafka_cluster.cluster.rbac_crn}/kafka=${confluent_kafka_cluster.cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
}

// Consumer requires auth to perform 'READ' operation on both respective consumer group 
resource "confluent_role_binding" "consumer-developer-read-from-group-rb" {
  principal = "User:${confluent_service_account.consumer-sa.id}"
  role_name = "DeveloperRead"
  crn_pattern = "${confluent_kafka_cluster.cluster.rbac_crn}/kafka=${confluent_kafka_cluster.cluster.id}/group=confluent_cli_consumer_*"
}


// PRODUCER
resource "confluent_service_account" "producer-sa" {
  display_name = var.producer-sa
  description  = var.producer-sa-desc
}

resource "confluent_role_binding" "producer-developer-write-rb" {
  principal   = "User:${confluent_service_account.producer-sa.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${confluent_kafka_cluster.cluster.rbac_crn}/kafka=${confluent_kafka_cluster.cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
}

resource "confluent_api_key" "producer-sa-api-key" {
  display_name = var.producer-api-key-name
  description  = var.producer-api-key-name
  owner {
    id          = confluent_service_account.producer-sa.id
    api_version = confluent_service_account.producer-sa.api_version
    kind        = confluent_service_account.producer-sa.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.cluster.id
    api_version = confluent_kafka_cluster.cluster.api_version
    kind        = confluent_kafka_cluster.cluster.kind

    environment {
      id = confluent_environment.env.id
    }
  }
}