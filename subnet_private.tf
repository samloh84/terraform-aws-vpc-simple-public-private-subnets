
locals {
  private_subnet_availability_zones = coalescelist(var.availability_zones, data.aws_availability_zones.availability_zones.names)
  private_subnet_cidr_blocks        = coalescelist(var.private_subnet_cidr_blocks, [for i in range(0, length(local.private_subnet_availability_zones)) :cidrsubnet(var.cidr_block, 8, i+length(local.public_subnet_availability_zones))])
}

resource "aws_subnet" "private" {
  count = length(local.private_subnet_availability_zones)

  vpc_id                   = aws_vpc.main.id
  availability_zone        = local.private_subnet_availability_zones[count.index]
  cidr_block               = local.private_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = false


  tags = merge(local.default_tags, {
    Name = "${var.name}-private-subnet-${local.public_subnet_availability_zones[count.index]}"
    VPC = var.name
  })
}
