// SECURITY ADMIN 

variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}

// APPLICATION

variable "app" {
  description = "Streaming application name"
  type        = string
}


// ADMIN
variable "env" {
  description = "Confluent Cloud Environment"
  type        = string
}

variable "cluster_name" {
  description = "Confluent Kafka Cluster Name"
  type        = string
}

variable "cluster_availability_mode" {
  description = "Confluent Kafka Cluster Availability"
  type        = string
}


variable "cloud_provider" {
  description = "Confluent Cloud Provider "
  type        = string
}

variable "cloud_region" {
  description = "Confluent Cloud Region "
  type        = string
}

// IAM

// KAFKA ADMIN
variable "admin-sa" {
  description = "Confluent Cloud Admin Service Account"
  type        = string
}

variable "admin-sa-desc" {
  description = "Confluent Cloud Admin Service Account"
  type        = string
  default     = "Confluent Cloud Admin Service Account"
}

variable "admin-api-key-name" {
  description = "Confluent Cloud Admin Service Account API Key Name"
  type        = string
}

variable "admin-api-key-desc" {
  description = "Confluent Cloud Admin Service Account API Key Desc"
  type        = string
}


// KAFKA PRODUCER
variable "producer-sa" {
  description = "Confluent Cloud Producer Service Account"
  type        = string
}

variable "producer-sa-desc" {
  description = "Confluent Cloud Producer Service Account"
  type        = string
  default     = "Confluent Cloud Producer Service Account"
}

variable "producer-api-key-name" {
  description = "Confluent Cloud Producer Service Account API Key Name"
  type        = string
}

variable "producer-api-key-desc" {
  description = "Confluent Cloud Producer Service Account API Key Desc"
  type        = string
}


// KAFKA CONSUMER
variable "consumer-sa" {
  description = "Confluent Cloud Consumer Service Account"
  type        = string
}

variable "consumer-sa-desc" {
  description = "Confluent Cloud Consumer Service Account"
  type        = string
  default     = "Confluent Cloud Consumer Service Account"
}

variable "consumer-api-key-name" {
  description = "Confluent Cloud Consumer Service Account API Key Name"
  type        = string
}

variable "consumer-api-key-desc" {
  description = "Confluent Cloud Consumer Service Account API Key Desc"
  type        = string
}


// Features

variable "schema_registry_package" {
  description = "Confluent Cloud schema registry package"
  type        = string
  default     = "ESSENTIALS"
}

variable "schema_registry_package_id" {
  description = "Confluent Cloud schema registry package id"
  type        = string
  default     = "sgreg-2"
}


// Consumer 
# variable "consumer_project_id" {
#   type    = string
#   description = "consumer project id"
# }

# variable "consumer_vpc" {
#   type    = string
#   description = "consumer vpc network name"
# }

# variable "confluent_cidr" {
#   type    = string
#   description = "confluent ip address Range required for VPC Peering & Egress connection "
# }

# variable "import_custom_routes" {
#   description = "The Import Custom Routes option enables connectivity to a Confluent Cloud cluster in Google Cloud from customer premise or other clouds, such as AWS and Azure, through a customer VPC that is peered with Confluent Cloud in the same region."
#   type        = bool
#   default     = false
# }







