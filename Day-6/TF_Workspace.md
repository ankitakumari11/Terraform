# 🧠 What is a Terraform Workspace?
Imagine you're managing cloud infrastructure (like servers, networks, etc.) using Terraform.Now, you want to use the same code for different environments—say:
- Development (dev)
- Testing (test)
- Production (prod)
But you don't want the infrastructure for dev to interfere with prod.

### 💡 Here's where Terraform Workspaces come in:
A workspace is like a separate drawer or folder where Terraform keeps:
- its own state file
- any resource tracking info
✅ This means: You can use the same Terraform code but have different environments and states isolated from each other.


### 🧰 How It Works:  
By default, Terraform creates a workspace called default.  
You can create your own:  
```
terraform workspace new dev
terraform workspace new prod
```
To switch between them:  
```
terraform workspace select dev
terraform workspace select prod
```

Then run your usual Terraform commands:  
```
terraform plan
terraform apply
```
> Terraform uses a different state file for each workspace (e.g. in S3, it might look like env:dev/terraform.tfstate vs env:prod/terraform.tfstate).


### HOW TERRAFORM WORKSPACES WORK

If u are having 3 workspaces like :
- DEV
- STAGE
- PROD
 <br>
u r going to have 3 statefiles i.e 1 for each environment so that u can use the same code again and again. Suppose u r having a


- main.tf
- dev.tfvars
- stage.tfvars
- prod.tfvars
  

and in each tfvars u have different variable for instance type like , t2.micro, t2.medium ,t2.large. Now u r running main and dev.tfvars when u want to create infra in dev environment then for stage and etc. but here what will happend , It will create a signgle statefile and when u will run the same code for 2nd time (main + stage.tfvars) , it will cause errror i.e either it would ask u to destroy the previously created dev infra becoz in statefile , it is already recorded that u have created or it will just see if any update in code is there otherwise leave as it is becoz infra is already created and recorded in statefile. 
<br>
Here comes **terraform workspaces** , what it will do , it will create separate statefile for each environment so that  u can run the same code 3 times or the number of environments u have defined in the code.
<br>

Now If u want 3 new environments , u need to run:

```
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
```
<br>
Now it will create 1 separate folder for each environment state file:

![image](https://github.com/user-attachments/assets/1e56858c-27f1-4170-a9f9-c6630039baf6)

<br>
Now if u want to switch btw environments :  

`terraform workspace select dev`

If u want to see on which workspace u r in :

`terraform workspace now`

Now suppose u have single terraform.tfvars and u r changing the instance_type to t2.micro and right now u r at dev and running `terraform apply`. 

![image](https://github.com/user-attachments/assets/aa1c3c79-72c4-42a9-85d3-736966cde524)

See it will create the instance and create statefile inside dev workspace , now if u will switch to stage and change the variable to t2.medium , then it will again create the insatnce btw t2.medium and will cretae a new statefile inside stage env.

![image](https://github.com/user-attachments/assets/e7e48f13-1f41-4a66-99a4-886e0e6501e8)


Now rather than changing the same tfvars for each environment manually , u can use other methods:
- U can create 3 tfvars and then run like this:
  - `terraform apply -var-file=prod.tfvars`
  - `terraform apply -var-file=stage.tfvars`
  - `terraform apply -var-file=dev.tfvars`
- U can use below method i.e dont write in tfvars , directly write in main.tf:
```
variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
```

Now above `terraform.workspace` in `instance_type` will change to the environment on which u r working , if u r switching the environment using `terraform switch` , it will map the value accordingly.
  






