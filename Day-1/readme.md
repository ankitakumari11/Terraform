# Terraform

![image](https://github.com/user-attachments/assets/09174c54-0006-417a-bf91-10ae4ecb5274)  

Suppose as a devops engineer u r asked to create S3 bucket , so u can do it in multiple ways:
- Cloud console (manually) , but if suppose creating a bucket takes 2 mins and u have to create 100 buckets then 200 buckets so very much time consuming.
- Programming: CLI or API programming (Api means a way with the help of which u r able to communicate with cloud providers/console like aws,oci etc, But suppose there are a lot of resources that u have to create like vpc,nsg,ec2 ,s3 etc. Then for that u need to have a good programming language.
- So solve the above issue , cloud providers introduce **Cloud formation Template** in Json/yaml format. This is called Infrastructure as a code (eg Json format,yaml ).why it is called infrastructure as a code becoz here u r writing the infrastructure in the form of code.


Now every cloud provider have developed their own templates like:
- AWS:
  - Cloud formation templates
- AZURE:
  - Resource manager
- OPENSTACK:
  - Heat template

### Why Terraform ?

Now u cannot learn all the templates for each cloud providers.So terraform said we will come with universal approach and dont learn all these , just learn terraform. And u just write for what cloud provider u are writing terraform that's it.Terraform also uses API as a code internally but u dont need to worry about that.

There are multiple reasons why Terraform is used over the other IaC tools but below are the main reasons.

1. **Multi-Cloud Support**: Terraform is known for its multi-cloud support. It allows you to define infrastructure in a cloud-agnostic way, meaning you can use the same configuration code to provision resources on various cloud providers (AWS, Azure, Google Cloud, etc.) and even on-premises infrastructure. This flexibility can be beneficial if your organization uses multiple cloud providers or plans to migrate between them.

2. **Large Ecosystem**: Terraform has a vast ecosystem of providers and modules contributed by both HashiCorp (the company behind Terraform) and the community. This means you can find pre-built modules and configurations for a wide range of services and infrastructure components, saving you time and effort in writing custom configurations.

3. **Declarative Syntax**: Terraform uses a declarative syntax, allowing you to specify the desired end-state of your infrastructure. 

4. **Plan and Apply**: Terraform's "plan" and "apply" workflow allows you to preview changes before applying them. This helps prevent unexpected modifications to your infrastructure and provides an opportunity to review and approve changes before they are implemented.
   
5. **Integration with Other Tools**: Terraform can be integrated with other DevOps and automation tools, such as Docker, Kubernetes, Ansible, and Jenkins, allowing you to create comprehensive automation pipelines.

6. **HCL Language**: Terraform uses HashiCorp Configuration Language (HCL).It's human-readable and expressive, making it easier for both developers and operators to work with. Now if u saying u want to write code for AWS then HCL will convert it into aws API , similarily for other cloud providers.There are other languages also but HCL is very popular.

#### <ins> Some keywords </ins>

To get started with Terraform, it's important to understand some key terminology and concepts. Here are some fundamental terms and explanations.

1. **Provider**: A provider is a plugin for Terraform that defines and manages resources for a specific cloud or infrastructure platform. 
Examples of providers include AWS, Azure, Google Cloud, and many others. 
You configure providers in your Terraform code to interact with the desired infrastructure platform.

2. **Resource**: A resource is a specific infrastructure component that you want to create and manage using Terraform. Resources can include virtual machines, databases, storage buckets, network components, and more. Each resource has a type and configuration parameters that you define in your Terraform code.

3. **Module**: A module is a reusable and encapsulated unit of Terraform code. Modules allow you to package infrastructure configurations, making it easier to maintain, share, and reuse them across different parts of your infrastructure. Modules can be your own creations or come from the Terraform Registry, which hosts community-contributed modules.

4. **Configuration File**: Terraform uses configuration files (often with a `.tf` extension) to define the desired infrastructure state. These files specify providers, resources, variables, and other settings. The primary configuration file is usually named `main.tf`, but you can use multiple configuration files as well.

5. **Variable**: Variables in Terraform are placeholders for values that can be passed into your configurations.

8. **State File**: Terraform maintains a state file (often named `terraform.tfstate`) that keeps track of the current state of your infrastructure. This file is crucial for Terraform to understand what resources have been created and what changes need to be made during updates.

9. **Plan**: A Terraform plan is a preview of changes that Terraform will make to your infrastructure. When you run `terraform plan`, Terraform analyzes your configuration and current state, then generates a plan detailing what actions it will take during the `apply` step.

10. **Apply**: The `terraform apply` command is used to execute the changes specified in the plan. It creates, updates, or destroys resources based on the Terraform configuration.

11. **Workspace**: Workspaces in Terraform are a way to manage multiple environments (e.g., development, staging, production) with separate configurations and state files.

### Install Terraform
Windows Install Terraform from the Downloads [Page](https://developer.hashicorp.com/terraform/downloads)
    
