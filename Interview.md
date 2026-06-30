### 1. How do you remove a stuck lock?
```
terraform force-unlock LOCK_ID
```

### 2. What is deadlock in Terraform?  
In Terraform, deadlock usually refers to a situation where the state file remains locked due to a failed or interrupted operation. Since Terraform uses state locking to prevent concurrent changes, other users cannot run terraform plan or terraform apply until the lock is released. We typically verify that no operation is running and then use terraform force-unlock to remove the stale lock.

### 3. if u r creating a vm and u want to create inisde a vpc , but u have not created that vpc so how will u get that vpc cidr?  
If the VPC already exists ,Then you don't create it. Instead, fetch it using a data source.  
```  
data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["prod-vpc"]
  }
}
```  
Now you can access its CIDR: `data.aws_vpc.existing.cidr_block`  
or its ID: `data.aws_vpc.existing.id`  
NOTE: During VM creation block , It does not require the VPC CIDR directly. The VPC CIDR is mainly used when creating subnets, route tables, security rules, or network planning.  

### 4. if u have a vm and its entry is not there in statefile , how will u bring to teraaform?
If the VM already exists but is not tracked in the Terraform state, I would import it into Terraform.  
1. First, create a resource block for the existing VM.The resource block should match the existing infrastructure as closely as possible.  
```
resource "aws_instance" "web" {
  # Configuration matching the existing EC2 instance
}
```
2. Import the existing resource :`terraform import aws_instance.web i-0123456789abcdef0`    
where:
- aws_instance.web = Terraform resource address
- i-0123456789abcdef0 = Existing EC2 Instance ID
3. Verify the state :`terraform state list`
Output: `aws_instance.web`
4. Run Terraform Plan :`terraform plan`  
If your configuration matches the actual EC2 instance, Terraform should show:  
```
No changes.
Infrastructure is up-to-date.
```
