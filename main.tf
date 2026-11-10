resource "aws_vpc" "main" {
   cidr_block = var.cidr_block
   instance_tenancy = "default"
   tags = local.vpc_final_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = local.ig_final_tags
}

#    resource "aws_internet_gateway_attachment" "main" {
#       internet_gateway_id = aws_internet_gateway.main.id
#       vpc_id = aws_vpc.main.id
#    }