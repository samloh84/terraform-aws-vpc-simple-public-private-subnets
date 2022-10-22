resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id


  tags = merge(local.default_tags, {
    Name = "${var.name}-public-route-table"
    VPC  = var.name
  })

}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(aws_subnet.public)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}