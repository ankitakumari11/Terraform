## Creating AWS eks cluster using Terraform  

1. Create ec2 instance (ubuntu).
2. create IAM user on aws (give administrative rights).
3. Create Secret access key for that IAM user (select command line interface) , download credentials in .csv
4. Go to instance and download aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
   ```
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   apt-get install unzip
   unzip awscliv2.zip
   sudo ./aws/install
   ```
6. Configure aws cli: `aws configure`

    <img width="1920" height="161" alt="image" src="https://github.com/user-attachments/assets/9fce4d1b-e229-4974-b7b7-6e6346a2136e" />
    
7. Install Terraform on the server Install Terraform | Terraform | HashiCorp Developer :
   https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
     
   <img width="1920" height="857" alt="image" src="https://github.com/user-attachments/assets/94d4ea94-9c83-431c-9aac-0f777ce2e962" />

8. mkdir scripts
9. cd scritps
10. We will create this script to just test if terraform working prorply or not so will create an ec2 for testing.
11. vim main.tf
```
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "sample_machine"{
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
}
```
12. `terraform destroy`

# Creation of VPC and its components using Terraform

Infrstructure we want:
1. One custom VPC: 10.0.0.0/16
2. Create Two subnets
   - private (10.0.1.0/24) : just create a subnet and named it as private-subnet in one AZ
   - public (10.0.2.0/24) :just create a subnet and named it as public-subnet in another AZ and allow public ip allocation.
4. Route tables:
   - Rename the default route table as - public-rt
   - create another route table and named as - private-rt
5. Create Internet Gateway and attach it with custom vpc created.
6. Edit the route tables:
   - Add route rules in both of them (public and private) : 0.0.0.0/0 and custom IGW
7. Attach public-rt with public subnet (subnet association)
8. Attach private-rt with private subnet (subnet association)
9. Create an ec2 instance in public subnet inside the custom vpc.

**STEPS TO ACHIEVE THIS VIA TERRAFORM**

1. cd scripts
2. mkdir aws-vpc-terraform && cd aws-vpc-terraform
3. vi variables.tf
```
variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI for us-east-1"
  default     = "ami-0c02fb55956c7d316"
}

variable "key_name" {
  description = "Name of your existing AWS Key Pair"
  default     = "ank-key" # Replace with your real keypair
}
```
4. vi main.tf
```
provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}

# Public Subnet in AZ1
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Private Subnet in AZ2
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az2
  tags = {
    Name = "private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Default Route Table (used as public RT)
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Associate Public RT to Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_default_route_table.public_rt.id
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "private-rt"
  }
}

# Associate Private RT to Private Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Security Group for EC2 SSH
resource "aws_security_group" "public_sg" {
  name        = "public-ec2-sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

# EC2 instance in public subnet
resource "aws_instance" "public_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_sg.id]

  tags = {
    Name = "public-instance"
  }
}
```
5. vi outputs.tf
```
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "public_ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}
```
6. terraform init
7. terraform plan
8. terraform apply

<img width="1919" height="837" alt="image" src="https://github.com/user-attachments/assets/1772c98f-78a4-4c00-99fb-fba591afdff2" />

9. Now you can go on aws console and check:
   - vpc:

     <img width="1895" height="196" alt="image" src="https://github.com/user-attachments/assets/81e38522-ff08-4d46-a7c9-3f9f7a53728c" />

   - subnets:

     <img width="1920" height="243" alt="image" src="https://github.com/user-attachments/assets/bcb6d7de-9d55-42c0-9857-8a033f25907a" />

   - Internet-gateway:

     <img width="1920" height="183" alt="image" src="https://github.com/user-attachments/assets/2747df1b-387c-4ab9-8473-9dd5d72c3496" />

   - Route tables:

     <img width="1919" height="234" alt="image" src="https://github.com/user-attachments/assets/71decb02-74f1-4335-9fcd-6edb6907d005" />

     <img width="1920" height="386" alt="image" src="https://github.com/user-attachments/assets/820f2463-77b6-43ee-af48-b4b63538e258" />

   - ec2:

     <img width="1909" height="357" alt="image" src="https://github.com/user-attachments/assets/6ba3cb95-9a53-4760-894f-bc57ecba22a8" />

10. Now if you want to destroy: `terraform destroy`

