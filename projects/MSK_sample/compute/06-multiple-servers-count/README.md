# count: MSK_sample multi-server test

New isolated Terraform state. Start with zero servers (`servers = {}` or `server_count = 0`).

PowerShell:
```powershell
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
terraform init
terraform validate
terraform plan
```
Set APPROVED compartment, network, image, server sizes and if applicable unused private IPs. Review plan and approval before `terraform apply`.

Verify using `terraform state list`, `terraform output` and OCI Console.

Cleanup: first ensure no important data or dependencies on test servers. `prevent_destroy=true` in `modules/multi-server-instance/main.tf` blocks deletes. For test cleanup only, set that module lifecycle flag to `false` temporarily, reduce server count / remove map keys, run `terraform plan`, inspect exact names and instance OCIDs, then `terraform apply` after approval. Restore `prevent_destroy=true` immediately afterward. This shared module edit can affect all users of the module; ensure no concurrent deployments. For `count`, remove servers at the end to avoid index shifts. For `for_each`, removing a map key deletes only the corresponding server, subject to plan and permissions.

Important: Instance launches use `preserve_boot_volume=false`; after terminating a test instance, its boot volume can be deleted. Do not use with existing production servers or data. IP assignment and network access depend on subnet and policy.
