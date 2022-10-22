resource "aws_route_table" "private" {
  count  = length(local.private_subnet_availability_zones)
  vpc_id = aws_vpc.main.id



  tags = merge(local.default_tags, {
    Name = "${var.name}-private-route-table-${local.private_subnet_availability_zones[count.index]}"
    VPC     = var.name
  })

}


resource "aws_route" "private_route" {
  count = length(local.private_subnet_availability_zones)

  route_table_id = aws_route_table.private[count.index].id

  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private_nat_gateway[count.index].id

}

resource "aws_route_table_association" "private_route_association" {
  count          = length(aws_subnet.private)
  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}