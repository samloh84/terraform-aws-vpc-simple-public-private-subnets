resource "aws_eip" "private_nat_gateway" {
  count = length(local.private_subnet_availability_zones)
  vpc = true
  tags = merge(local.default_tags, {
    Name = "${var.name}-nat-gateway-elastic-ip-${local.private_subnet_availability_zones[count.index]}"
    VPC     = var.name
  })

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "private_nat_gateway" {
  count = length(local.private_subnet_availability_zones)

  allocation_id = aws_eip.private_nat_gateway[count.index].id
  subnet_id = aws_subnet.public[count.index].id


  tags = merge(local.default_tags, {
    Name = "${var.name}-nat-gateway-${local.private_subnet_availability_zones[count.index]}"
    VPC     = var.name
  })

  depends_on = [aws_internet_gateway.internet_gateway]

}
