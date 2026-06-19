1. How do you remove a stuck lock?
```
terraform force-unlock LOCK_ID
```

2. What is deadlock in Terraform?  
In Terraform, deadlock usually refers to a situation where the state file remains locked due to a failed or interrupted operation. Since Terraform uses state locking to prevent concurrent changes, other users cannot run terraform plan or terraform apply until the lock is released. We typically verify that no operation is running and then use terraform force-unlock to remove the stale lock.
