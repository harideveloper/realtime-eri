
// DB User
resource "mongodbatlas_database_user" "user" {
  username           = var.dbuser
  password           = var.dbuser_password
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWriteAnyDatabase" 
    database_name = var.database_name

    // readWriteAnyDatabase@admin

    // role_name  = "readWriteAnyDatabase"
    // database_name = "admin"
   

  }
  labels {
    key   = "admin"
    value = "admin"
  }
}
output "admin" {
  value = mongodbatlas_database_user.user.username
}
