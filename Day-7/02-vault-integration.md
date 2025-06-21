# Vault Integration

Here are the detailed steps for each of these steps:

## Create an AWS EC2 instance with Ubuntu

To create an AWS EC2 instance with Ubuntu, you can use the AWS Management Console or the AWS CLI. Here are the steps involved in creating an EC2 instance using the AWS Management Console:

- Go to the AWS Management Console and navigate to the EC2 service.
- Click on the Launch Instance button.
- Select the Ubuntu Server xx.xx LTS AMI.
- Select the instance type that you want to use.
- Configure the instance settings.
- Click on the Launch button.

## Install Vault on the EC2 instance

To install Vault on the EC2 instance, you can use the following steps: Take ssh of the instance and run following commands  

**Install gpg**

```
sudo apt update && sudo apt install gpg
```

**Download the signing key to a new keyring**

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

**Verify the key's fingerprint**

```
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

**Add the HashiCorp repo**

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```
sudo apt update
```

**Finally, Install Vault**

```
sudo apt install vault
```

## Start Vault.

To start Vault, you can use the following command:

```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

Also, Implement security rules in **NSGS/SECURITY LISTS** :
```
Ingress:
Source :0.0.0.0/0
Protocol: TCP
Destination port: 8200
```

Now write the following address in url to access the vault:
```
http://instance-ip-address:8200
```
<br>

![image](https://github.com/user-attachments/assets/34b82da2-ab52-4afa-a09a-2059b8a4fe97)

<br>

To login into the vault:  
*Method: Token  
 Token : Root token (from start vault command output)*  
 
## Configure Terraform to read the secret from Vault.

![image](https://github.com/user-attachments/assets/7356e87f-edc4-49e8-bdbb-0a587c1f7747)

![image](https://github.com/user-attachments/assets/ae211afd-27de-42e4-af88-133e3f62dc7f)

![image](https://github.com/user-attachments/assets/2ab26b98-b9d6-46d0-b9ae-e7f85cad17ce)

![image](https://github.com/user-attachments/assets/af62839d-18f2-4aab-b71a-21d726bc408d)

![image](https://github.com/user-attachments/assets/4ced2f30-7360-484d-bad4-dc9a134d7181)


Detailed steps to enable and configure AppRole authentication in HashiCorp Vault:

1. **Enable AppRole Authentication**:

![image](https://github.com/user-attachments/assets/dc70fa0c-fe16-48a8-bb26-1c62afd9792b)

![image](https://github.com/user-attachments/assets/05af79c0-26f7-4723-8248-b149e04161a2)

![image](https://github.com/user-attachments/assets/effd413a-a250-42f4-9a2d-6012abddcae8)

![image](https://github.com/user-attachments/assets/c6807610-a0c9-4826-97b5-67bdf26d502e)

![image](https://github.com/user-attachments/assets/525d2bb4-aef5-4dab-9315-c85058df35a9)

   

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

**Using Vault CLI**:

Run the following command to enable the AppRole authentication method:

```bash
vault auth enable approle
```

This command tells Vault to enable the AppRole authentication method.

2. **Create an AppRole**:

We need to create policy first,

```
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}

path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}


path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/create" {
capabilities = ["create", "read", "update", "list"]
}
EOF
```

Now you'll need to create an AppRole with appropriate policies and configure its authentication settings. Here are the steps to create an AppRole:

**a. Create the AppRole**:

```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

3. **Generate Role ID and Secret ID**:

After creating the AppRole, you need to generate a Role ID and Secret ID pair. The Role ID is a static identifier, while the Secret ID is a dynamic credential.

**a. Generate Role ID**:

You can retrieve the Role ID using the Vault CLI:

```bash
vault read auth/approle/role/my-approle/role-id
```

Save the Role ID for use in your Terraform configuration.

**b. Generate Secret ID**:

To generate a Secret ID, you can use the following command:

```bash
vault write -f auth/approle/role/my-approle/secret-id
   ```

This command generates a Secret ID and provides it in the response. Save the Secret ID securely, as it will be used for Terraform authentication.
