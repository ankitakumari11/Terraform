# MIGRATION OF EXISTING INFRA TO TERRAFORM

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


