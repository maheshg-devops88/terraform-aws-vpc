resource "aws_vpc" "main" {
   cidr_block = var.cidr_block
   instance_tenancy = "default"
   tags = local.vpc_final_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = local.ig_final_tags
}

resource "aws_subnet" "public_subnet" {
  count = length(local.az_zones)
  vpc_id = aws_vpc.main.id
  availability_zone = local.az_zones[count.index]
  tags = {
   Name = "${var.project}-${var.environment}-publicsnet-${local.az_zones[count.index]}"
}
}
