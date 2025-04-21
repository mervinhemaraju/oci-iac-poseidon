# Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

# Get ths private ips for computes
# data "oci_core_private_ips" "tool_server" {
#   ip_address = local.networking.ip_address.tool_server
#   subnet_id  = oci_core_subnet.public_mgmt.id

#   depends_on = [
#     oci_core_subnet.public_mgmt
#   ]
# }

# data "oci_core_private_ips" "app_server" {
#   ip_address = local.networking.ip_address.app_server
#   subnet_id  = oci_core_subnet.public_mgmt.id

#   depends_on = [
#     oci_core_subnet.public_mgmt
#   ]
# }
