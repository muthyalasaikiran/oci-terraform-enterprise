# MSK_sample OCI Terraform – Full package update (count + for_each)

This ZIP is based on the user-uploaded working `oci-terraform-reusable` folder. Original module/project files were retained unchanged, except that old packaged plan binaries are excluded. No Terraform states or private tfvars are included.

Added:
- `modules/multi-server-instance`: standalone image-based test instance module with optional fixed private IP and delete protection.
- `projects/MSK_sample/09-multiple-servers-for-each`: map keyed by server name, different shapes/sizes/IPs.
- `projects/MSK_sample/10-multiple-servers-count`: homogeneous auto-numbered servers, OCI-assigned private IPs.

DO NOT OVERWRITE an active local Terraform folder, .terraform directory, local state, or tfvars. Extract in a different location and compare. If adopting, back up state first, copy only new folders, or plan a careful migration. Existing FSS may still be live. Creation is disabled by default (`servers={}`, `server_count=0`).

PowerShell demonstration:
```
cd projects\MSK_sample\09-multiple-servers-for-each
Copy-Item terraform.tfvars.example terraform.tfvars
# configure approved values
terraform init
terraform validate
terraform plan
```

Test each project separately; do not run Terraform from root or use global `terraform destroy`. Back up `.tfstate` and variable files outside any distribution ZIP. Provider downloads/init and actual cloud plans must be validated in your environment.
