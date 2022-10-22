resource "aws_security_group" "private" {
  name        = "${var.name}-private-subnet"
  description = "${var.name}-private-subnet"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.default_tags, {
    Name = "${var.name}-private-security-group"
    VPC  = var.name
  })

}

resource "aws_security_group_rule" "allow_ssh_ingress_from_public_to_private" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private.id
  to_port                  = 22
  type                     = "ingress"
  source_security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "allow_rdp_ingress_from_public_to_private" {
  from_port                = 3389
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private.id
  to_port                  = 3389
  type                     = "ingress"
  source_security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "allow_http_ingress_from_public_to_private" {
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private.id
  to_port                  = 80
  type                     = "ingress"
  source_security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "allow_https_ingress_from_public_to_private" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private.id
  to_port                  = 443
  type                     = "ingress"
  source_security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "allow_all_ingress_from_private_to_self" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.private.id
  to_port                  = 0
  type                     = "ingress"
  source_security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "allow_all_egress_from_private_to_internet" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.private.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}


