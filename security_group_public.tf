resource "aws_security_group" "public" {
  name        = "${var.name}-public-subnet"
  description = "${var.name}-public-subnet"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${var.name}-public-security-group"
    VPC  = var.name
  })
}

resource "aws_security_group_rule" "allow_ssh_ingress_from_management_to_public" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = coalescelist(var.management_cidr_ranges, [
    local.local_ip
  ])
}

resource "aws_security_group_rule" "allow_rdp_ingress_from_management_to_public" {
  from_port         = 3389
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 3389
  type              = "ingress"
  cidr_blocks       = coalescelist(var.management_cidr_ranges, [
    local.local_ip
  ])
}


resource "aws_security_group_rule" "allow_https_ingress_from_internet_to_public" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.public.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_egress_from_public_to_internet" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.public.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}


