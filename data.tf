data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
    default = true
}
data "aws_route_table" "main" {
   route_table_id = var.main_route_table_id
 }