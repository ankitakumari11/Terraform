provider "aws" {  
  region = "us-east-1"
}
# You can also create a file named providers.tf and write the provider like aws,oci,gcp etc in that.

resource "aws_instance" "example" {
    ami = var.ami_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value
}


# now to run the code , go to day-3 folder then run -
# terraform init (this will initialise the terraform)
# terraform plan (to see what changes are going to be made)
# terraform apply (to apply the changes)

# Once u run terraform init , u will see "terraform.tfstate" : It keeps the record of all the changes u have made.

# Here if we are running terraform.apply inside /modules/ec2_instance then it is fine. But here we going to run this entire directory ie. /modules/ec2_instance as a module and going to refere it in main.tf in root folder or u can say day-3 folder.
