# Modules

The advantage of using Terraform modules in your infrastructure as code (IaC) projects lies in improved organization, reusability, and maintainability. Here are the key benefits:

1. **Modularity**: Terraform modules allow you to break down your infrastructure configuration into smaller, self-contained components. This modularity makes it easier to manage and reason about your infrastructure because each module handles a specific piece of functionality, such as an EC2 instance, a database, or a network configuration.

2. **Reusability**: With modules, you can create reusable templates for common infrastructure components. Instead of rewriting similar configurations for multiple projects, you can reuse modules across different Terraform projects. This reduces duplication and promotes consistency in your infrastructure.

3. **Simplified Collaboration**: Modules make it easier for teams to collaborate on infrastructure projects. Different team members can work on separate modules independently, and then these modules can be combined to build complex infrastructure deployments. This division of labor can streamline development and reduce conflicts in the codebase.

4. **Versioning and Maintenance**: Modules can have their own versioning, making it easier to manage updates and changes. When you update a module, you can increment its version, and other projects using that module can choose when to adopt the new version, helping to prevent unexpected changes in existing deployments.

5. **Abstraction**: Modules can abstract away the complexity of underlying resources. For example, an EC2 instance module can hide the details of security groups, subnets, and other configurations, allowing users to focus on high-level parameters like instance type and image ID.

6. **Testing and Validation**: Modules can be individually tested and validated, ensuring that they work correctly before being used in multiple projects. This reduces the risk of errors propagating across your infrastructure.

7. **Documentation**: Modules promote self-documentation. When you define variables, outputs, and resource dependencies within a module, it becomes clear how the module should be used, making it easier for others (or your future self) to understand and work with.

8. **Scalability**: As your infrastructure grows, modules provide a scalable approach to managing complexity. You can continue to create new modules for different components of your architecture, maintaining a clean and organized codebase.

9. **Security and Compliance**: Modules can encapsulate security and compliance best practices. For instance, you can create a module for launching EC2 instances with predefined security groups, IAM roles, and other security-related configurations, ensuring consistency and compliance across your deployments.

# 🌱 What is a Terraform Module?
A module in Terraform is just a collection of .tf files that do a specific job—like creating an EC2 instance, an S3 bucket, or a VPC.Modules help you:

- Reuse infrastructure code
- Organize large configurations
- Follow best practices (like DRY – Don’t Repeat Yourself)

In simple words: Modules = functions in programming.Just like functions, modules can accept inputs (variables) and return output  
🔧 Let's Build a Simple Module (to create an EC2 instance)  
🗂 Folder Structure  

```
terraform-ec2-project/
├── main.tf               <-- main root config
├── variables.tf          <-- variables used in root
├── outputs.tf            <-- outputs from root
├── terraform.tfvars      <-- values for variables
└── modules/
    └── ec2_instance/
        ├── main.tf        <-- actual EC2 code
        ├── variables.tf   <-- input vars for the module
        └── outputs.tf     <-- outputs from module
```
✅ Step-by-Step Code  
1. modules/ec2_instance/main.tf
```
resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.name
  }
}
```
2. modules/ec2_instance/variables.tf
```
variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "name" {
  description = "Instance Name Tag"
  default     = "MyEC2"
}
```
3. modules/ec2_instance/outputs.tf
```
output "instance_id" {
  value = aws_instance.this.id
}
```
4. main.tf (root level)
```
provider "aws" {
  region = "us-east-1"
}

module "my_ec2" {
  source        = "./modules/ec2_instance"
  ami           = var.ami
  instance_type = var.instance_type
  name          = "TestEC2"
}
```
5. variables.tf (root level)  
```
variable "ami" {
  description = "AMI to use"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}
```
6. terraform.tfvars  
```
ami = "ami-0c55b159cbfafe1f0"
```
8. outputs.tf (optional at root)
```
output "my_ec2_instance_id" {
  value = module.my_ec2.instance_id
}
```
🚀 How to Run This  
From the root directory:
```
terraform init      # initializes the module
terraform plan      # shows what will be created
terraform apply     # creates resources
```

🔁 What Happens Behind the Scenes?  
- Terraform sees module "my_ec2" and jumps into the folder ./modules/ec2_instance/
- It passes values (ami, instance_type, etc.) to that module
- The module uses those inputs to create an EC2 instance

The module also returns output, like the instance_id  

### 🔑 Summary

| Term               | Meaning                                                         |
|--------------------|-----------------------------------------------------------------|
| `module` block     | Calls a reusable piece of code                                  |
| `source`           | Tells Terraform where to find that module                       |
| `variables.tf`     | Defines what values the module expects                          |
| `outputs.tf`       | Defines what values the module returns after running            |
| `terraform.tfvars` | Optional file to feed values to variables                       |




