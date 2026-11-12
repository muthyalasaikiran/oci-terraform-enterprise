# Terraform operating SOP — all projects

## Before a new change

1. Confirm the right **project leaf directory** and correct OCI tenancy/region/profile, resource limits, AD, subnet, NSG, and IAM approvals.
2. Determine whether the project already manages any real OCI resources (`terraform state list`). Do not overwrite `.tfstate` or run `terraform init -reconfigure` casually.
3. Copy `.tfvars.example` into locally ignored `terraform.tfvars` and fill in approved IDs, names, tags and flags.
4. Run `terraform init` (without `-upgrade` unless approved), `terraform validate`, and `terraform plan -out=review.tfplan`. Inspect all create, replace and destroy actions.
5. Obtain the infrastructure/change approval, then `terraform apply .\review.tfplan`.
6. Check `terraform output`, `terraform state list` and OCI Console. `terraform plan` should normally show **No changes** after apply.

## Common commands and purposes

| Command | Purpose / caution |
|---|---|
| `terraform init` | Initialize modules/backend/providers; normally no OCI modifications |
| `terraform fmt -check -recursive` | Check HCL formatting, does not modify source |
| `terraform fmt -recursive` | Format source; review Git diff before commit |
| `terraform validate` | Validate configuration (doesn't confirm AWS/OCI IAM, quotas, network) |
| `terraform state list` | View tracked resources; empty state doesn't necessarily prove nothing exists in cloud |
| `terraform plan` | Preview desired changes; **does not apply** |
| `terraform plan -out=review.tfplan` | Save proposed execution plan locally (ignored by Git) |
| `terraform show review.tfplan` | Review saved plan; can contain sensitive details |
| `terraform apply review.tfplan` | Execute the saved plan; requires approval |
| `terraform output` | Display exported outputs (may contain IDs and sensitive information) |
| `terraform plan -destroy` | Preview destroying **all managed resources in current state** |
| `terraform destroy` | Delete all managed resources in this root; irreversible where backups are absent |
| `terraform state show <address>` | Inspect a tracked resource, may expose sensitive details |
| `git status`, `git diff`, `git log` | Review code changes and history; do not change OCI by themselves |

## Actual tested storage examples (2026-11-10)

- **Block Volume:** New 100 GB data volume -> attach (required approved running instance for that attempted paravirtualized attachment) -> FULL backup -> restore to new volume. Cleanup was **restored volume -> backup -> detach original -> original volume**.
- **FSS:** New File System, new Mount Target and new Export using approved network references. Three resources created, state reconciled, and three resources destroyed. NFS client mount functionality **not tested**.
- **Object Storage:** New private Standard bucket and optional 128-byte text object -> verify -> delete object -> delete empty bucket. Both had `prevent_destroy` protection during cleanup, temporarily disabled and later restored.

These are lab/test results. They do **not** prove every compute workflow, IAM scenario, or production environment is validated.

## Deletion safety and `prevent_destroy`

`prevent_destroy = true` intentionally blocks resource destruction. It is a safety control, not an error to fix by default. For a disposable approved test resource, an operator may temporarily set it to false after backup and change approval, inspect a plan limited to exactly the intended resource, perform cleanup, then restore it to true and commit the protected version.

If turning a flag (`create_backup`, `create_restore`, `upload_sample_object`) from true to false causes Terraform to plan deletion, that is expected resource-count behavior; do **not** assume it only disables future actions.

Never run unreviewed `terraform destroy` in an environment that may still manage production/shared resources. For FSS ensure data is not in use and cleanup is authorized. For Object Storage ensure the bucket is empty and no retained versions or real data remain. For attached data volumes check safe operating-system unmount before detach; do not format/mount unrelated disks.

## Approved operating model

- A single folder should not be shared by simultaneous Terraform operators using local state; implement secure remote state and locking before team collaboration.
- Use branches and PRs to review source changes; provision only with explicit cloud change approval.
- Before considering production, standardize provider constraints, module validation, state backend, least-privilege policies, rollback, approvals and documentation.
