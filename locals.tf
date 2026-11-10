locals {
    common_tags = {
        project = var.project 
        environment = var.environment
        terraform = true
    }

    vpc_tags = {
        Name = "${var.project}-${var.environment}-vpc"
    }
    igw_tags = "${var.project}-${var.environment}-igw"

    vpc_final_tags = merge(local.vpc_tags , local.common_tags)

    ig_final_tags = merge(local.igw_tags, local.common_tags)
}