# MIGRATION TO TERRAFORM & DRIFT DETECTION

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
![image](https://github.com/user-attachments/assets/8c1a910f-829b-47b3-9065-523fccc562c1)

