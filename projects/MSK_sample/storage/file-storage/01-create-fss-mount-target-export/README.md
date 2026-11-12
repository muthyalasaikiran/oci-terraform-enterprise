# MSK_sample UAT — OCI File Storage Terraform (independent state)

This add-on creates a **new file system**, **new mount target**, and **new export** in one plan. It does **not** modify any existing compute, block volume, or their Terraform state.

## Preparation

1. Confirm the UAT APP compartment, availability domain and approved **mount-target subnet**. OCI mount targets consume several private IP addresses; ensure free addresses and correct subnet routing.
2. Obtain FSS mount-target NSG approval and configure NFS ports/directions per OCI networking guidance (commonly TCP 111, 2048, 2049, 2050 and UDP 111, 2048; verify for your NFS protocol and environment). **This package does not create security rules.**
3. Copy `terraform.tfvars.example` to `terraform.tfvars`. Replace *all* placeholder values. Confirm `client_cidr` and export `READ_ONLY` vs `READ_WRITE` with the network/application teams. Export defaults to `READ_ONLY` and squashes root privileges.
4. Validate there is no existing mount target/export name collision (names are not unique) and that this is a new, approved UAT test deployment.

## Safe rollout

```powershell
cd C:\OCI_Terraform_Automation\oci-terraform-reusable\projects\MSK_sample\04-file-storage
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
code .\terraform.tfvars
terraform init
terraform fmt -check
terraform validate
terraform state list
terraform plan
```

Only after reviewing the plan and obtaining approval, `terraform apply`. Expected: **3 to add** and no modifications/deletions. After apply: `terraform output` and verify OCI File Storage state, mount-target private IP and export.

## Cleanup caution

Each module sets `prevent_destroy = true`; removal requires an approved maintenance action and temporary changes to *these new shared modules*. Before removing, unmount clients, confirm no NFS use, and review `terraform plan -destroy` carefully. Then restore `prevent_destroy = true`. Deleting the file system destroys its contents and may be irreversible. **Do not apply to production.**

## Notes

- Independent Terraform state in this project. Never reuse/remove other project state files.
- Mount target private IPs are exposed as OCI private-IP OCIDs: resolve actual address via OCI CLI or Console before mounting.
- `terraform.tfvars` is deliberately absent from this ZIP to force review of network approvals.
