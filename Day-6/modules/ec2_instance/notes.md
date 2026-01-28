**Why are we passing ami in root main.tf when we r already passing inside module**  

Root passes values into the module, and the module passes those values into resources.  
```
terraform.tfvars
      ↓
root variables
      ↓
module "ec2_instance"
      ↓
module variables
      ↓
aws_instance
```  
  
so main.tf is actually passing the variables values to the module from tfvars and then inisde module the module is passing variables to the resource
