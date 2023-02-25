output "vpc" {
  value       = module.vpc
  description = "Sho vpc module created resource infomations"
}

output "private_subet_cidr_blocks" {
    value = module.vpc.private_subnets_cidr_blocks
}

output "intra_subet_cidr_blocks" {
    value = module.vpc.intra_subnets_cidr_blocks
}

output "public_subet_cidr_blocks" {
    value = module.vpc.public_subnets_cidr_blocks
}