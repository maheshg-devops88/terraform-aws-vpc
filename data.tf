data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
    default = true
}
data "aws_route_table" "main" {
   id = var.main_route_table_id
 }