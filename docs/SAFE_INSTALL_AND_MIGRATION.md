# Safe installation and state migration

1. Keep your current `C:\OCI_Terraform_Automation\oci-terraform-reusable` folder unchanged while it contains any `.tfstate`, `.tfvars`, or possibly live resources. In particular, inspect the FSS project state before any migration.
2. Extract this package to a **new** folder, e.g. `C:\OCI_Terraform_Automation\enterprise-preview`. Do not extract over the current main project.
3. To validate a workflow, copy its `.tfvars.example` to `.tfvars` and supply approved non-production data. Run `terraform init`, `terraform validate`, and `terraform plan` in its **leaf project folder**. An empty default map in multi-server examples should plan no servers.
4. To migrate an existing *stateful* project, back up state securely, obtain a maintenance window, identify backend and workspace, and plan a controlled state and configuration move. Compare `terraform state list` and a zero-change `terraform plan` before applying. **Never apply** a plan that proposes unexpected destroy/recreate.
5. Do not commit or share API keys, `.tfvars`, state or plan files. Keep original source server/boot volume out of test Terraform ownership.
6. FSS, mount target and export creation was reported successful in the prior project, but its final destroy/cleanup status is NOT confirmed. Preserve the old state's access until reconciled.
7. The internal module directory has been organized into `modules/compute/` and `modules/storage/`. Root workflow module source paths have been updated; the resource logic was not intentionally changed. Terraform/provider validation still must be performed locally.

## `count` vs `for_each`

Use `count` for identical numbered servers and `for_each` for stable server names with individual IP/CPU/RAM. Do not switch a live resource from `count` to `for_each` without explicit state moves.
