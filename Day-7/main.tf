provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "<>:8200"  # instance-ip:8200
  skip_child_token = true # recommended by hashicorp

  auth_login {
    path = "auth/approle/login" # here we are logging to vault using approle method

    parameters = {
      role_id = "<>" # you will take it from vault, use the commands mentioned in readme file 
      secret_id = "<>"
    }
  }
}

data "vault_kv_secret_v2" "example" { # data keyword used to read something from a platform
  mount = "secret" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}
