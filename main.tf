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
  cidr_block = local.public_cidr_block[count.index]
  tags = {
   Name = "${var.project}-${var.environment}-publicsnet-${local.az_zones[count.index]}"
}
}

resource "aws_subnet" "private_subnet" {
  count = length(local.az_zones)
  vpc_id = aws_vpc.main.id
  availability_zone = local.az_zones[count.index]
  cidr_block = local.private_cidr_block[count.index]
  tags = {
   Name = "${var.project}-${var.environment}-privatesnet-${local.az_zones[count.index]}"
}
}

resource "aws_subnet" "db_private_subnet" {
  count = length(local.az_zones)
  vpc_id = aws_vpc.main.id
  availability_zone = local.az_zones[count.index]
  cidr_block = local.db_private_cidr_block[count.index]
  tags = {
   Name = "${var.project}-${var.environment}-db-privatesnet-${local.az_zones[count.index]}"
}
}

resource "aws_route_table" "public_rt" {
   vpc_id = aws_vpc.main.id
   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = aws_internet_gateway.main.id
   }
   tags = {
       Name = "${var.project}-${var.environment}-public-rttable"
   }
  
}

resource "aws_route_table" "private_rt" {
   vpc_id = aws_vpc.main.id
   tags = {
       Name = "${var.project}-${var.environment}-private-rttable"
   }
  
}

resource "aws_route_table" "db_private_rt" {
   vpc_id = aws_vpc.main.id
   tags = {
       Name = "${var.project}-${var.environment}-dbprivate-rttable"
   }
  
}

resource "aws_eip" "elasticip" {
  domain = "vpc"
  region = "us-east-1"

  tags = {
    Name = "${var.project}-${var.environment}-eip"
  }
}




resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.elasticip.id
    subnet_id = aws_subnet.public_subnet[0].id

   tags = {
     Name = "${var.project}-${var.environment}-nat-gw"
   }

}

resource "aws_route_table_association" "public_rt_assoc" {
  count = length(local.az_zones)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count = length(local.az_zones)
  subnet_id = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_private_rt_assoc" {
  count = length(local.az_zones)
  subnet_id = aws_subnet.db_private_subnet[count.index].id
  route_table_id = aws_route_table.db_private_rt.id
}