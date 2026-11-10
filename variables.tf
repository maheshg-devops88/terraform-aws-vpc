variable "cidr_block" {
   type = string
   default = "10.0.0.0/16"
}

variable "project" {
  type = string 
  
}

variable "environment" {
  type = string
}

variable "vpc_tags" {
  type = map(any)
  default = {}
}

variable "igw_tags" {
  type = map(any)
  default = {}
}


variable "tags" {
  default = {}
}

variable "public_cidr_block" {
  default = {}
}

variable "private_cidr_block" {
  default = {}
}

variable "db_private_cidr_block" {
  default = {}
}

variable "is_peering_required" {
  default = false
  type = bool
}

variable "main_route_table_id" {
   default = string
} 