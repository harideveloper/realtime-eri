# resource "google_gke_hub_membership" "membership" {
#   membership_id = "${var.application}-my-membership"
#   endpoint {
#     gke_cluster {
#     #   resource_link = "//container.googleapis.com/${google_container_cluster.gke.id}" 
#       resource_link = "//container.googleapis.com/${data.google_container_cluster.gke.id}"
#     }
#   }
#   provider = google-beta
#   depends_on = [module.gke]
# }

# resource "google_gke_hub_feature" "feature" {
#   name     = "servicemesh"
#   location = "global"

#   provider = google-beta
# #   depends_on = [
# #     google_project_service.project
# #   ]
# }

# resource "google_gke_hub_feature_membership" "feature_member" {
#   location   = "global"
#   feature    = google_gke_hub_feature.feature.name
#   membership = google_gke_hub_membership.membership.membership_id
#   mesh {
#     management = "MANAGEMENT_AUTOMATIC"
#   }
#   provider = google-beta
# }


# # resource "null_resource" "install_asm" {
# #   triggers = {
# #     # Trigger this resource whenever you want to reinstall ASM (e.g., when the package URL changes)
# #     always_run = "${timestamp()}"
# #   }
  
# #   provisioner "local-exec" {
# #     command = "bash"
# #     interpreter = ["-c"]
# #     # Shell script to download ASM, install it, and verify the installation
# #     inline = <<-EOT
# #       # Download ASM package
# #       curl -LO curl -LO https://storage.googleapis.com/gke-release/asm/istio-1.18.2-asm.4-linux-amd64.tar.gz

# #       # Extract the ASM package
# #       tar -xzf istio-1.18.2-asm.4-linux-amd64.tar.gz
# #       cd istio-1.18.2-asm.4
      
# #       # Install ASM using istioctl
# #       ./bin/istioctl install -f istio-operator.yaml

# #       # Verify the installation
# #       kubectl get pods -n istio-system
# #       kubectl get svc -n istio-system
# #     EOT
# #   }
# # }

# resource "null_resource" "config_sync_secret" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-exc"]
#     command     = "${path.module}/scripts/installASM.sh"
#     # environment = {
#     #   ACM_NAMESPACE = var.acm_namespace
#     # }
#   }
#   triggers = {
#     build_number = "${timestamp()}"
#     script_sha1  = sha1(file("${path.module}/scripts/installASM.sh")),
#   }
#   #depends_on = [module.acm]
#   depends_on = [google_gke_hub_feature_membership.feature_member]
# }

