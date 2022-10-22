locals {
  public_subnet_availability_zones = coalescelist(var.availability_zones, data.aws_availability_zones.availability_zones.names)
  public_subnet_cidr_blocks        = coalescelist(var.public_subnet_cidr_blocks, [for i in range(0, length(local.public_subnet_availability_zones)) :cidrsubnet(var.cidr_block, 8, i)])
}

resource "aws_subnet" "public" {
  count = length(local.public_subnet_availability_zones)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = local.public_subnet_availability_zones[count.index]
  cidr_block              = local.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true


  tags = merge(local.default_tags, {
    Name = "${var.name}-public-subnet-${local.public_subnet_availability_zones[count.index]}"
    VPC = var.name
  })
}
