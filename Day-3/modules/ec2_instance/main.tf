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
