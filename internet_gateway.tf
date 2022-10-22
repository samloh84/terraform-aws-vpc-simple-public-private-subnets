resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.default_tags, { Name = "${var.name}-internet-gateway" })
}

