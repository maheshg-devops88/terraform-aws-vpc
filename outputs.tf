output "vpc_id" {
   value = aws_vpc.main.id
}

output "ig_id" {
  value = aws_internet_gateway.main.id
}

output "az_zones" {
  value = data.aws_availability_zones.available.names
}