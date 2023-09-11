
#  Mongo Cluster

resource "mongodbatlas_cluster" "cluster-test" {
  project_id              = mongodbatlas_project.project.id
  name                    = var.cluster_name

  provider_name = var.cloud_mode
  backing_provider_name = var.cloud_provider_name
  provider_region_name = var.region
  provider_instance_size_name = var.cluster_size
  cloud_backup                            = false
  auto_scaling_disk_gb_enabled            = false
  auto_scaling_compute_enabled            = false
  auto_scaling_compute_scale_down_enabled = false
}



