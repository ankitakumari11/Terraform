# SCENARIO 1 : MIGRATION OF EXISTING INFRA TO TERRAFORM

Suppose , there is a infrastructure already created on a cloud provider like aws,oci and u want to import that infra and use the same for some other infra.

```
provide "aws" {
  region = "us-east-1"
}

import {
  id = "122eb3ihrdb"
  to = aws_instance.example
}

```

The above code is importing an instance info using instance id and importing it to aws_instance and giving it a local name i.e example.  

Below commands u have to run on terminal to import:  
```
terraform init
terraform plan -generate-config-out=generated_resources.tf
```

The above code is creating a terraform file name **generated_resources.tf**. And automatically the file will contain the code for new infra:  
![image](https://github.com/user-attachments/assets/8c1a910f-829b-47b3-9065-523fccc562c1)]

Now u have to copy the resource part from generated_resources.tf and paste it in ur maim.tf (now remove import block). And run the below commands:

```
terraform import aws_instance.example 122eb3ihrdb # in the end its the instance id
terraform apply

```
Now when u wrote terraform apply , it wont create a new instance becoz it will see that the instance is already created. So now u can see that u have imported the exisiting infra to terraform.  

![image](https://github.com/user-attachments/assets/c7a07376-f937-4c28-9ad5-15db2ab94b83)

![image](https://github.com/user-attachments/assets/d87cd403-6e34-4706-ab52-b8e5a1c4d0ed)


# SCENARIO 2 : DETECTION OF DRIFT IN TERRAFORM

 What is Drift Detection in Terraform?  
 When using Terraform, the goal is to keep your infrastructure in the exact state defined in your Terraform code. But sometimes things change outside of Terraform — like someone manually edits a server setting, deletes a resource, or adds something new.That's where drift detection comes in.  

 ### 📦 Example Scenario:
 - You use Terraform to create an EC2 instance with a tag: Environment = Production.
 - Later, someone logs into the AWS console and manually changes the tag to Environment = Staging.  
 Now:
 - Terraform’s state file still thinks the tag is Production.
 - Real infrastructure now says Staging.
 - 🧨 This mismatch is called "drift".

### 🛠️ What Drift Detection Does:  
- Detects changes made outside Terraform.
- Alerts you about mismatches between Terraform’s state and real infrastructure.
- Helps you reconcile: either update your code or re-apply the correct config.

### Methods to detect drift:  
- 🧪 1. How to Run Drift Detection:
``` terraform plan ```
  - This command Compares the state file with the actual live infrastructure.
  - Shows any changes required to bring it back in sync.
  - You’ll see output like: `~ tag = "Staging" -> "Production"`   : That means Terraform has detected drift.  

- 🔍 2. terraform refresh
  - What it does: Syncs Terraform’s state file with the actual state of cloud resources.
  - Usage: `terraform refresh`
  - ⚠️ Note: It updates the state file — so run only if you're ready to overwrite the current state.  
 
- 🔐 3. Audit Logs-Based Drift Detection
  - How it works:Use cloud provider’s audit logs to check if changes were made outside Terraform (e.g., via console or API).
  - If a user (not Terraform) made the change — trigger an alert.  
  - ✅ Example with OCI:
    - Enable Audit Service.
    - Filter logs where actor is not Terraform's IAM user.
    - Integrate with SIEM or alerting tools (like Splunk, PagerDuty, or OCI Events + Notifications).
- 🔁 4. CI/CD Scheduled Drift Check
  - Run something like:  
  - ```
    terraform init
    terraform plan -detailed-exitcode
    ```
  - Exit code 2 = changes detected (drift)
  - Send Slack/email/alert if drift is found.  
