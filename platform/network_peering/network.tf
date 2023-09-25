## vpc module

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
  network                = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc}"
  peer_network           = "https://www.googleapis.com/compute/v1/projects/${var.confluent_project_id}/global/networks/${var.confluent_vpc}"

  // Routes
  export_custom_routes   = false
  import_custom_routes   = false
 
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