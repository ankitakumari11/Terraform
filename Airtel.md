**Features of Terraform:**
- Terraform has statefiles to keep record of all the changes.
- Terraform has locking mechanism so if 2 people are working at the same time then due to .lock file , terraform will allow only one of the user to make changes and the next user will do later.
- 
  
1. Create a vm: Terraform-vm
2. Create IAM user.

![image](https://github.com/user-attachments/assets/ab0273bb-1293-4a17-8fa1-be987d3d4aa6)

3. Delete existing user  
![image](https://github.com/user-attachments/assets/746081f6-8744-4790-916b-6811d10ca476)  

![image](https://github.com/user-attachments/assets/94e6e162-7bf9-4ccd-ab95-94205bc6b84a)  

![image](https://github.com/user-attachments/assets/dc6f3be0-fd66-42d1-8b24-efc5f5927341)  

![image](https://github.com/user-attachments/assets/4a20c33e-6374-4650-bb06-f0152535ee18)  

![image](https://github.com/user-attachments/assets/83789755-a2a1-4869-b33e-df455309cfa7)  

![image](https://github.com/user-attachments/assets/7d37d8ab-0402-4996-abb3-d66dca6dd2c0)  

![image](https://github.com/user-attachments/assets/d4f9d784-25e8-4f27-b8a3-03627f139711)  



4. Install Terraform on the server
Install Terraform | Terraform | HashiCorp Developer






`root@ip-172-31-27-151:~/scripts# terraform validate`  
![image](https://github.com/user-attachments/assets/3376e2a7-0901-4374-87f1-5e873ef043ab)


`root@ip-172-31-27-151:~/scripts# terraform plan`  
{it will give you the plan , what things going to be done by terraform for you to recheck}  

![image](https://github.com/user-attachments/assets/c30d61b6-7a9d-47b7-988b-361163d04930)



`root@ip-172-31-27-151:~/scripts# terraform apply`

![image](https://github.com/user-attachments/assets/c0456a36-3a3e-4328-bfde-242c20d7b3cb)  

![image](https://github.com/user-attachments/assets/a25dae95-44ca-494c-a6c1-6afa87c848c9)  

![image](https://github.com/user-attachments/assets/1633d2c5-c490-4d82-8279-e4cde1677468)  

Now see u have a statefile: 

  
  
![image](https://github.com/user-attachments/assets/68583d6d-7178-4e06-bc07-80b1ae52ca03)

Now the statefile already contains the data so everytime u run the scripts it will first check the statefile and then run it and if the resource already there then it wont create resource.  

![image](https://github.com/user-attachments/assets/488e0183-d730-4794-8ef8-0a34ba71a045)

If u want to destroy the resource: 

![image](https://github.com/user-attachments/assets/35a64599-efd9-436c-91d9-a91d7af4dc5f)

![image](https://github.com/user-attachments/assets/2d735fbd-4422-46b1-84fc-d7942a553648)  

Backup file contains the info regarding previously deleted resource: 

![image](https://github.com/user-attachments/assets/ec49f423-e680-410b-b404-6be92b595d53)

Now again `terraform init` , `terraform plan` and `terraform apply` (it will create the vm again).  
Now again go to main.tf and now add the tags having name of vm.  

![image](https://github.com/user-attachments/assets/52e77b99-ab42-41d1-9832-6cb492da1f87)  

`terraform plan`  
`terraform apply`  

![image](https://github.com/user-attachments/assets/9bfded8d-910d-45aa-9e99-59671c4e9ce8)

### <ins>Variables</ins>  

main.tf  
```
resource "aws_instance" "ec2_instance" {
    ami = var.AMI
    instance_type = var.machine_type
}
```

vi provider.tf  
```
provider "aws" {
     access_key = var.AWS_ACCESSKEY
	 secret_key = var.AWS_SECRETKEY
	 region = var.AWS_REGION
}
```
vi variable.tf
```
# Access Key
variable AWS_ACCESSKEY {
  default = "xxxxxx"
}

#Secret key
variable AWS_SECRETKEY {
  default = "xxxxx"
}

#Region
variable AWS_REGION {
  default = "us-east-1"
}
#AMI
variable AMI {
  default = "xxxxxxx"
}

#instance_type
variable machine_type {
  default = "t2.micro"
}
```

Now u dont need to modify the main.tf if u just want to change the AMI or any other thing , u can just change the specific file.  
Now since u were already having main.tf and u replaced it with new main.tf , variable.tf and provider.tf and then u run terraform apply then it will first delete the repvoiusly created vm formed from preivious main.tf becoz now it is not there in the new configuration (main.tf) file.

![image](https://github.com/user-attachments/assets/be1c6ac0-c360-47b7-9e56-74a7aef83f21)


### <ins>Use terraform without using AWS Access and Secret key</ins>

Now rather than including access key and secret key in yml files , we configure aws cli and can run the yml files directly. 

Install AWS CLI  
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt-get update
apt-get install unzip
unzip awscliv2.zip
cd aws
./install
```

![image](https://github.com/user-attachments/assets/52327ae7-0a49-46f4-b5cd-59f3df9798b7)  


Give below information below: 
1. Access key: 
2. Secret key:
3. Region:
4. Format:

`aws configure`  

![image](https://github.com/user-attachments/assets/81c8d157-b72c-448e-8e4e-729e3cc3706d)

To check the aws credentials(access_key and secret_key): `cat ~/.aws/credentials`  
![image](https://github.com/user-attachments/assets/0f39e98f-78c5-4d98-a9ef-841df011cfe0)  

Now destroy the already existed resources. `terraform destroy`

![image](https://github.com/user-attachments/assets/73d0e10f-a3b5-436b-baeb-39e16e124b17)

Now create the following files and then run terraform plan and apply
vi main.tf
```
resource "aws_instance" "ec2_instance" {
    ami = "ami-020cba7c55df1f615"
	instance_type = "t2.micro"
}
```

vi provider.tf  
```
provider "aws" {
    region = var.AWS_REGION
}
```
  
vi vars.tf  
```
#Region
variable AWS_REGION {
  default = "us-east-1"
}
```

`terraform plan`  and `terraform apply`  
![image](https://github.com/user-attachments/assets/87c15481-4741-47c1-96bc-99acbdf300ef)  

### <ins>Creating Security lists and attaching to vm</ins>

Delete the existing resource.  
`terraform destroy`  

vi main.tf  
```
# Create new security group
resource "aws_security_group" "sandbox_sg" {
    name = "sandbox security group"
        vpc_id = var.vpc.id

        ingress {
            description = "inbound"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = [var.vpc.cidr]
        }

        egress {
            description = "outbound"
                from_port = 0
                to_port = 0
                protocol = "tcp"
                cidr_blocks = [var.vpc.cidr]
        }

        tags = {
           sg_name = "sandbox-security-group"
        }
 }
 
# Create Ec2 instance
resource "aws_instance" "ec2_instance" {
    ami = "ami-020cba7c55df1f615"
        instance_type = "t2.micro"
        vpc_security_group_ids = [aws_security_group.sandbox_sg.id]
        tags = {Name = "HTTP_SERVER2"}
        key_name = "aws-demo-key"
        count = 2
 }

```

 vim provider.tf  
 ```
provider "aws" {
     region = var.AWS_REGION
 }
```

vim vars.tf  
```
variable AWS_REGION {
  default = "us-east-1"
 }
 
 variable "vpc" {
   default = {
     id = "vpc-09d3e7e8a5ec1aac3"
         cidr = "0.0.0.0/0"
   }
 }
```

So it created a secuirty group (NSG) under the vpc u defined in vpn id and it will attach that secuirity group with aws instances here u r creating 2 instances and witha keypair.  

![image](https://github.com/user-attachments/assets/f2cc068d-52d2-42c1-aaba-7d80b83bfefa)

  





