locals {
  default_region = "us-west-2"
  common_tags = {
    ManagedBy = "Aristeu Roriz Neto"
    Owner     = "Peregrine Tech"
    CreatedAt = "2022-08-17"
  }
  aws_ecr_url = "081283953628.dkr.ecr.${var.default_region}.amazonaws.com"
}
