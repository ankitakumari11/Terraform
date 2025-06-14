provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance" # now here u r reffering to a module named /modules/ec2_instance
  ami_value = "ami-053b0d53c279acc90" # this is the input value u r giving to variables inside the module , now here inside the module u dont need terraform.vartf
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-019ea91ed9b5252e7". # replace this
}

# You can also take modules from terraform registery , there we have online inbuilt modules present on the website which u can use directly.
