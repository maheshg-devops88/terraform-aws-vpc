locals {
    common_tags = {
        project = var.project 
        environment = var.environment
        terraform = true
    }

    vpc_tags = {
        Name = "${var.project}-${var.environment}-vpc"
    }
    igw_tags = {
        Name = "${var.project}-${var.environment}-igw"
    }
    vpc_final_tags = merge(local.vpc_tags , local.common_tags)

    ig_final_tags = merge(local.igw_tags, local.common_tags)

    az_zones = slice(data.aws_availability_zones.available.names,0,2)

    tags = merge(var.tags, local.common_tags)

    public_cidr_block = ["10.0.1.0/24","10.0.2.0/24"]

    private_cidr_block = ["10.0.11.0/24","10.0.12.0/24"]

    db_private_cidr_block = ["10.0.21.0/24","10.0.22.0/24"]
}