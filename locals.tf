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
}