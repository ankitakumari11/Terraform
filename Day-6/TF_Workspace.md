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
Here comes **terraform workspaces** , what it will do , it will create separate statefile for each environment so that  u can run the same code 3 times or the number of environments u have defined in the code.


