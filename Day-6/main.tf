provider "aws" {
  region = "us-east-1"
}

# whenever u r writing modular approach , the only thing that u r required to write is variables and module function.
# We have created terraform.tfvars for passing variable values to this file.

variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

# module "ec2_instance" : this is just the local name u r giving to this module block.

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}


