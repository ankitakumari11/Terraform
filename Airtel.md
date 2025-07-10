1. Create a vm: Terraform-vm
2. Create IAM user.

![image](https://github.com/user-attachments/assets/ab0273bb-1293-4a17-8fa1-be987d3d4aa6)

Delete existing user  
![image](https://github.com/user-attachments/assets/746081f6-8744-4790-916b-6811d10ca476)

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
