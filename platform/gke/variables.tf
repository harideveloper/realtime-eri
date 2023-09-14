
// Global
variable "project_id" {
  type    = string
  description = "Google Cloud Project ID"
}

variable "application" {
  type    = string
  description = "Name of application or usecase, will be appended to the resource names"
}

variable "region" {
  type    = string
  description = "Google Cloud Region for GKE Hosting"
}

// Network 
variable "subnet_name" {
  type    = string
  description = "Primary Subnet for GKE Hosting"
}

variable "subnet_ip" {
  type    = string
  description = "ip address Range for Primary Subnet required for GKE Hosting"
}

variable "pod_cidr" {
  type    = string
  description = "ip address Range required for Pods in GKE"
}

variable "svc1_cidr" {
  type    = string
  description = "ip address Range required for Services in GKE"
}

variable "svc2_cidr" {
  type    = string
  description = "Secondary ip address Range required for GKE"
}

// Confluent 
variable "confluent_cidr" {
  type    = string
  description = "confluent ip address Range required for VPC Peering & Egress connection "
}

## GKE Cluster Module 

variable "gke_zone" {
  type    = string
  description = "Google Cloud Zone for GKE Hosting"
}

variable "gke_channel" {
  type    = string
  default = "REGULAR"
}

variable "gke_enabled" {
  type    = bool
  description = "Boolean Flag to Skip GKE Creation for local testing"
  default = true
}

variable "namespace" {
  type    = string
  description = "Kubernetes Namespace for the Project"
}

variable "krd_path" {
  type    = string
  description = "Kubernetes Manifests Paths"
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








