
// Global
variable "project_id" {
  type    = string
  description = "Google Cloud Project ID"
}

variable "application" {
  type    = string
  description = "Name of application or usecase, will be appended to the resource names"
}

variable "vpc" {
  type    = string
  description = "Name of application or usecase, will be appended to the resource names"
}


// Confluent

variable "confluent_project_id" {
  type    = string
  description = "Confluent Google Cloud Project ID"
}

variable "confluent_vpc" {
  type    = string
  description = "Confluent VPC"
}








