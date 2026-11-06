locals {
    common_tags = {
        project = var.project 
        environment = var.environment
        terraform = true
    }

    vpc_final_tags = merge(var.tags , local.common_tags)

    ig_final_tags = merge(var.tags, local.common_tags)
}