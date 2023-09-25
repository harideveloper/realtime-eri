
# variable "members" {
#   type = list(string)
#   default = [
#     # "hariprasad.sundharesan@gmail.com",
#     "hari.study.gcp@gmail.com"
#   ]
# }

resource "confluent_invitation" "hari-gcp" {
  //for_each  = toset(var.members)
  //email     = each.value
  email       = "hari.gcp.study@gmail.com"
  auth_type   = "AUTH_TYPE_LOCAL"
}

# data "confluent_users" "users" {}

# output "users" {
#   value = data.confluent_users.users.ids
# }

# data "confluent_invitation" "main" {
#   id = confluent_invitation.hari-gcp.id
# }

# output "invitation" {
#   value = data.confluent_invitation.main
# }

# output "invitation2" {
#   value = confluent_invitation.hari-gcp.id
# }

# output "invitation3" {
#   value = confluent_invitation.hari-gcp.user[0].id
# }




# data "confluent_organization" "org" {}

# output "org" {
#   value = data.confluent_organization.org
#   // sample value = "crn://confluent.cloud/organization=a6c785e3-1953-4040-a63a-51456b5ee649"
# }


# resource "confluent_role_binding" "ui-rb-operators" {
#   principal   = "User:${confluent_invitation.hari-gcp.user[0].id}"
#   role_name   = "EnvironmentAdmin"
#   crn_pattern = confluent_environment.env.resource_name
#   depends_on = [ confluent_invitation.hari-gcp ]
# }


# resource "confluent_invitation" "user1" {
#   email       = "user1.@gmail.com"
#   auth_type   = "AUTH_TYPE_LOCAL"
# }

# resource "confluent_role_binding" "role_binding_environment_dev_admins" {
#   principal   = "User:${confluent_invitation.user1.id}"
#   role_name   = "EnvironmentAdmin"
#   crn_pattern = confluent_environment.env.resource_name
#   depends_on = [ confluent_invitation.user1 ]
# }
