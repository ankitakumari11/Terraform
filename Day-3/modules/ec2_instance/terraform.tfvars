ami_value = "abcdefsg" # this is the kind of os u want for your instance
instance_type_value = "t2.micro"
subnet_id_value = "subnet-0123456"
aws_access_key = "abc"
# You can also pass key value pairs also here like secret key and all for authentication.
# Here terraform.tfvars is used to pass values to the variables inside variables.tf . U dont need to upload .tfvars files to github, u can directly say that the other person can create their own tfvars files.
