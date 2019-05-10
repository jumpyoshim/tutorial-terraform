resource "aws_instance" "sandbox" {
    ami = "ami-785c491f"
    instance_type = "t2.micro"
    subnet_id = "${data.terraform_remote_state.vpc.public_subnet_id}"
}

provider "aws" {
    region = "ap-northeast-1"
}

data "terraform_remote_state" "vpc" {
    backend = "s3"

    config {
        bucket = "jumpyoshim-sample-terraform"
        key = "infra/vpc/terraform.tfstate"
        region = "ap-northeast-1"
    }
}

terraform {
    backend "s3" {
        bucket = "jumpyoshim-sample-terraform"
        key = "infra/ec2/terraform.tfstate"
        region = "ap-northeast-1"
    }
}
