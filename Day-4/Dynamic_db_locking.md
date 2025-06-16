# 🧩 What’s the Problem?
When multiple people or systems run Terraform at the same time on the same infrastructure, it can cause:
- Conflicts
- Accidental overwrites
- Infrastructure breakage
This is especially risky when using a remote backend like S3 to store Terraform state.

# 🔒 What’s the Solution?

To prevent two Terraform operations from running at the same time, we use something called state locking.DynamoDB locking is a feature that helps with this.

## 🛠️ What is DynamoDB Locking in Terraform?
- DynamoDB is a NoSQL database service by AWS.
- Terraform uses a DynamoDB table to keep track of a lock.
- When someone runs terraform apply, it writes a lock entry in the table.
- While the lock is active, no one else can run Terraform on that state.
- Once the operation is done, Terraform removes the lock.

## 🤝 Why Use It?  
- Prevents race conditions (two people trying to change infra at the same time).
- Keeps your infrastructure safe and consistent.
- Essential for team environments using remote state in S3.

## 📦 How to Enable It?
When using S3 remote backend, just configure like this:  
```
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"   # <- This enables locking
    encrypt        = true
  }
}
```


*You need to create the DynamoDB table first:*  

```
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```
## 🔁 What Happens When Someone Else Tries?

If a lock already exists:
- Terraform will show a message like “Terraform is locked…”
- The second person will have to wait or force unlock if stuck.
