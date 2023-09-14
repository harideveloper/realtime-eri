## vpc module
module "vpc" {
  source = "terraform-google-modules/network/google"

  project_id   = var.project_id
  network_name = var.application
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = var.subnet_ip
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = "${var.subnet_name}-pod-cidr"
        ip_cidr_range = var.pod_cidr
      },
      {
        range_name    = "${var.subnet_name}-svc1-cidr"
        ip_cidr_range = var.svc1_cidr
      },
      {
        range_name    = "${var.subnet_name}-svc2-cidr"
        ip_cidr_range = var.svc2_cidr
      },
    ]
  }

  firewall_rules = [
  // GKE Firewall Rules
  {
    name        = "${var.application}-allow-all-10"
    description = "Allow Pod to Pod connectivity"
    direction   = "INGRESS"
    ranges      = ["10.0.0.0/8"]
    allow = [{
      protocol = "tcp"
      ports    = ["0-65535"]
    }]
  },
  // Confluent Egress Firewall Rules
  {
    name        = "${var.application}-confluent-egress"
    description = "Allow Pod to Pod connectivity"
    direction   = "EGRESS"
    ranges      = ["10.0.0.0/8"]
    allow = [{
      protocol = "tcp"    // kafka Connection Mechanism
      ports    = ["9092"] // kafka Ports
    }]
  },
  // Confluent api firewalls to https access 
  {
    name        = "${var.application}-confluent-api"
    description = "Allow Pod to Pod connectivity"
    direction   = "EGRESS"
    ranges      = ["10.0.0.0/8"]
    allow = [{
      protocol = "tcp"    // kafka Connection Mechanism
      ports    = ["443"] // kafka Ports
    }]
  },
  // SSH Connection for VMs
  {
    name        = "${var.application}-allow-ssh-vm"
    description = "Allow SSH Connectivity"
    direction   = "INGRESS"
    ranges      = ["0.0.0.0/0"] 
    allow = [{
      protocol = "tcp"   
      ports    = ["22"] // SSH
    }]
  },
  ]
}





// Custom Routes

// GKE to Confluent
# resource "google_compute_route" "confluent_egress_route" {
#   name         = "${var.application}-confluent_egress_route"
#   network      = module.vpc.network_name
#   destination_range = var.confluent_cidr
#   priority     = 1000
#   next_hop_gateway = google_compute_network_peer.confluent_egress_route.self_link
# }


// Confluent to GKE
# resource "google_compute_route" "confluent_ingress_route" {
#   name         = "${var.application}-confluent_ingress_route"
#   network      = "your-confluent-vpc-network-name"
#   destination_range = var.pod_cidr
#   priority     = 1000
#   next_hop_gateway = google_compute_network_peer.confluent_ingress_route.self_link
# }


// Network Peering

resource "google_compute_network_peering" "gke_to_confluent" {
  name                   = "${var.application}-gke-to-confluent-peering"
  network                = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${module.vpc.network_name}"
  peer_network           = "https://www.googleapis.com/compute/v1/projects/${var.confluent_project_id}/global/networks/${var.confluent_vpc}"

  // Routes
  export_custom_routes   = false
  import_custom_routes   = false

  depends_on   = [module.vpc]
  
}

# resource "google_compute_network_peering" "confluent_to_gke" {
#   name                   = "${var.application}-confluent_to_gke_peering"
#   network                = google_compute_network.confluent_vpc.self_link
#   peer_network           = module.vpc.network_name.self_link
#   auto_create_routes     = false 
#   export_custom_routes {
#     next_hop_gateway = true
#   }
#   import_custom_routes {
#     next_hop_gateway = true
#   }
# }