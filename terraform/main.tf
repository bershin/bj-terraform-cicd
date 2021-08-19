locals {
#   env_plat      = format("%s-%s", var.platform, var.env_type)
  server_prefix = format("%s%s", var.platform, var.env_type)
}