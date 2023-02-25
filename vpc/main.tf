provider "aws" {
    region = "ap-northeast-1"
}

data "aws_availability_zones" "available" {}

locals {
  name            = "development-${replace(basename(path.cwd), "_", "-")}"
  cluster_version = "1.24"
  region          = "ap-northeast-1"

  vpc_cidr = "10.1.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  # 常見案例 private_subnets 會設定 routing 到 internet 的功能
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]
  # intra_subnets 則是用於無法 routing 到 internet 的使用案例，例如建立內部調用的 lambda function，則 intra_subnets 會被指定使用
  # 可以參考 https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest (private versus intra 部分)
  intra_subnets   = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 52)]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}