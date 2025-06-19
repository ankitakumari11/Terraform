# 🧠 What is a Terraform Workspace?
Imagine you're managing cloud infrastructure (like servers, networks, etc.) using Terraform.Now, you want to use the same code for different environments—say:
- Development (dev)
- Testing (test)
- Production (prod)
But you don't want the infrastructure for dev to interfere with prod.

## 💡 Here's where Terraform Workspaces come in:
A workspace is like a separate drawer or folder where Terraform keeps:
- its own state file
- any resource tracking info
✅ This means: You can use the same Terraform code but have different environments and states isolated from each other.


## 🧰 How It Works:  
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
