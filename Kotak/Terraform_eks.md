## Creating AWS eks cluster using Terraform  

1. Create ec2 instance (ubuntu).
2. create IAM user on aws (give administrative rights).
3. Create Secret access key for that IAM user (select command line interface) , download credentials in .csv
4. Go to instance and download aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
   ```
   $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```
6. Configure aws cli: `aws configure`

    <img width="1920" height="161" alt="image" src="https://github.com/user-attachments/assets/9fce4d1b-e229-4974-b7b7-6e6346a2136e" />
    
7. Install Terraform on the server Install Terraform | Terraform | HashiCorp Developer :
   https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
     
   <img width="1920" height="857" alt="image" src="https://github.com/user-attachments/assets/94d4ea94-9c83-431c-9aac-0f777ce2e962" />

8. 
