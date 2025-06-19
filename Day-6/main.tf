provider "aws" {
  region = "us-east-1"
}

# whenever u r writing modular approach , the only thing that u r required to write is variables and module function.
# We have created terraform.tfvars for passing variable values to this file.

variable "ami" {
  description = "value"
}


# Now suppose u have this :
```
variable "instance_type" {
  description = "value"
  }
```
# And u r creating 3 tfvars, like prod,stage,dev,tfvars and in each u r writing instance_type = micro/medium or large. Now when u will run terraform apply 2nd time for medium then it will not create a new instance , it will just update the exisiting instance becoz u have already statefile created in the 1st run i.e micro. But we want to create new instance so for that we need different workspaces/environments so what it will do that it will create diffeerent statefiles for each and then u can run the same set of code again and again without the issue of updation the existing resource

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


