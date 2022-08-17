variable "region" {
  default = "us-west-2"
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "default_region" {
  type = string
}

variable "prefix" {
  type = string
}
