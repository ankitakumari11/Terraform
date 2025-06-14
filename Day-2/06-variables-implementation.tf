# Variables Demo

```hcl

# Define an input variable for the EC2 instance type
Here when u run terraform file , u can give input there itself for input variable otherwise it will take default value
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


# Define an input variable for the EC2 instance AMI ID
variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

# Configure the AWS provider using the input variables
provider "aws" {
  region      = "us-east-1"
}

# Create an EC2 instance using the input variables
resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
}

# Define an output variable to expose the public IP address of the EC2 instance
here aws_instance is the cloud provider , example_instance is the name of the instance and public_ip is the thing which we want as a output
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example_instance.public_ip
}

```
