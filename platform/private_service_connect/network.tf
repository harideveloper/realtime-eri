

resource "google_compute_address" "psc_endpoint_ip" {
 
  name         = "${var.application}-psc-endpoint"
  subnetwork   = var.subnet
  address_type = "INTERNAL"
}

# Private Service Connect endpoint
resource "google_compute_forwarding_rule" "psc_endpoint_ilb" {
  
  name = "${var.application}-psc-endpoint-forwardrule"

  target                = "https://www.googleapis.com/compute/v1/projects/${var.confluent_project_id}/global/networks/${var.confluent_vpc}"
  load_balancing_scheme = "" # need to override EXTERNAL default when target is a service attachment
  network               = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc}"
  ip_address            = google_compute_address.psc_endpoint_ip.id
}

// DNS 
# Private hosted zone for Private Service Connect endpoints
resource "google_dns_managed_zone" "psc_endpoint_hz" {
  name     = "${var.application}-psc-dns-zone"
  dns_name = "${var.application}.com."

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc}"
    }
  }
}


resource "google_dns_record_set" "psc_endpoint_rs" {
  name = "*.${google_dns_managed_zone.psc_endpoint_hz.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.psc_endpoint_hz.name
  rrdatas = [google_compute_address.psc_endpoint_ip.address]
}


resource "google_dns_record_set" "psc_endpoint_zonal_rs" {
  

  name = "*.${google_dns_managed_zone.psc_endpoint_hz.dns_name}"
  type = "A"
  ttl  = 60

  managed_zone = google_dns_managed_zone.psc_endpoint_hz.name
  rrdatas      = [google_compute_address.psc_endpoint_ip.address]
}




// Network Peering

# resource "google_compute_network_peering" "gke_to_confluent" {
#   name                   = "${var.application}-gke-to-confluent-peering"
#   network                = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc}"
#   peer_network           = "https://www.googleapis.com/compute/v1/projects/${var.confluent_project_id}/global/networks/${var.confluent_vpc}"

#   // Routes
#   export_custom_routes   = false
#   import_custom_routes   = false
 
# }

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