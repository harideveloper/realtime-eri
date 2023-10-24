
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


variable "subnet" {
  description = "The subnetwork name to provision Private Service Connect endpoint to Confluent Cloud"
  type        = string
}

# variable "subnet_zone" {
#   description = "A map of Zone to Subnet Name"
#   type        = map(string)
# }

variable "zone" {
  description = "GCP Zone hosting the service"
  type        = string
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








