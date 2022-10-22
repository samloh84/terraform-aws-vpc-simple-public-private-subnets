output "vpc" {
  value = aws_vpc.main
  description = "The VPC"
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "The VPC ID"
}

output "public_subnets" {
  value = aws_subnet.public
  description = "The VPC Public Subnets"
}

output "private_subnets" {
  value = aws_subnet.private
  description = "The VPC Private Subnets"
}


output "subnet_ids_public" {
  value = {for i in range(0, length(local.public_subnet_availability_zones)) : local.public_subnet_availability_zones[i]=>aws_subnet.public[i].id}
  description = "The VPC Public Subnets IDs. This is an map of Availability Zones to Subnet IDs."
}


output "subnet_ids_private" {
  value = {for i in range(0, length(local.private_subnet_availability_zones)) : local.private_subnet_availability_zones[i]=>aws_subnet.private[i].id}
  description = "The VPC Private Subnets IDs. This is an map of Availability Zones to Subnet IDs."
}


output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
  description = "The VPC Internet Gateway."
}

output "nat_gateways" {
  value = {for i in range(0, length(local.public_subnet_availability_zones)) : local.public_subnet_availability_zones[i]=>aws_nat_gateway.private_nat_gateway[i].id}
  description = "The VPC NAT Gateways. This is a map of Availability Zones to aws_nat_gateway objects."
}


output "public_security_group" {
  value = aws_security_group.public
  description = "The VPC Public Security Group."
}

output "private_security_group" {
  value = aws_security_group.private
  description = "The VPC Private Security Group."
}


output "public_security_group_id" {
  value = aws_security_group.public.id
  description = "The VPC Public Security Group ID."
}

output "private_security_group_id" {
  value = aws_security_group.private.id
  description = "The VPC Private Security Group ID."
}

