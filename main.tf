/**
 * # AWS VPC Simple Public Subnets
 *
 * This Terraform module creates an AWS VPC with Public and Private Subnets.
 *
 *
 *
 */

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = local.default_tags
}

