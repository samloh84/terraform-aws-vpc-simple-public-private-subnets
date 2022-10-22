variable "name" {
  type        = string
  description = "Name of VPC. Resources will be tagged with this Name."
}

variable "project" {
  type        = string
  description = "Name of Project. Resources will be tagged with this Project."
}
variable "owner" {
  type        = string
  description = "Name of Owner. Resources will be tagged with this Owner."
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR of the VPC."
}


variable "enable_dns_hostnames" {
  default     = true
  description = "Enable DNS Hostnames in VPC."
}
variable "enable_dns_support" {
  default     = true
  description = "Enable DNS Support in VPC."
}

variable "assign_generated_ipv6_cidr_block" {
  default = false
  description = "Assign generated IPV6 CIDR Block in VPC."
}


variable "availability_zones" {
  default = ["ap-southeast-1a"]
  description = "Availability Zones to create Public Subnets in."
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = null
  description = "Custom CIDR Blocks to assign to each Public Subnet."
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = null
  description = "Custom CIDR Blocks to assign to each Private Subnet."
}

variable "management_cidr_ranges" {
  type    = list(string)
  default = null
  description = "Management CIDR Ranges to allow SSH and RDP access into the Public Security Group."
}