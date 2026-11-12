# MSK_sample UAT - Existing Boot Volume -> FULL Backup -> Restore -> Create Server

## Intent and safety
- Source is an EXISTING boot-volume OCID. The source server and its boot volume are NOT managed, imported, changed, or deleted by this project.
- This project has its OWN Terraform state. Never copy a state file from another folder.
- New backup, restored boot volume and test instance use `prevent_destroy = true` initially.
- This is an UNTESTED addon template; run `terraform init`, `terraform validate`, `terraform plan` with your approved OCI setup before applying.
- A backup from a running server may be crash-consistent rather than application-consistent. Arrange app quiescence / backup window as required.
- Separate storage/compute costs and access policies apply; original image architecture must support requested shape.
- No SSH keys are injected by default; plan login/access (existing OS account keys / OCI console) with owner before test.

## Integration without overwriting existing work
1. Extract ZIP into a TEMP directory.
2. Copy `projects/MSK_sample/07-existing-boot-volume-backup-restore-create-server` into your EXISTING `oci-terraform-reusable/projects/MSK_sample/`.
3. The `modules/boot-volume-backup` and `modules/boot-volume-restore` are provided as optional reusable modules; merge into existing `modules` only if names are absent. The new project's `main.tf` intentionally uses self-contained resources so it can be added without changing old project files and so staged cleanup remains explicit.
4. Do NOT replace any existing `terraform.tfstate`, `.terraform`, modules or folders.

## Windows PowerShell: getting started
```powershell
cd 'C:\OCI_Terraform_Automation\oci-terraform-reusable\projects\MSK_sample\07-existing-boot-volume-backup-restore-create-server'
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
code .\terraform.tfvars
oci session validate --profile DEFAULT   # Optional if using session auth; otherwise use oci iam region list --profile DEFAULT
terraform init
terraform fmt -check
terraform validate
terraform state list
```
Fill approved values. Confirm `terraform state list` is empty on first use.

## Stage 1: Create ONLY FULL backup
Set `create_backup = true`, `create_restore = false`, `create_server = false`. Then:
```powershell
terraform plan -out=backup.tfplan
terraform show backup.tfplan
terraform apply backup.tfplan
terraform output
```
Expect 1 add (backup only). Wait until backup state AVAILABLE in OCI.

## Stage 2: Restore a DIFFERENT boot volume
Set `create_backup = true`, `create_restore = true`, `create_server = false`. Then:
```powershell
terraform plan -out=restore.tfplan
terraform show restore.tfplan
terraform apply restore.tfplan
terraform output
```
Expect 1 add (restored boot volume only), wait until AVAILABLE.

## Stage 3: Create a new TEST server (optional)
Set approved `subnet_id`, shape and sizing. Set all 3 flags `true`.
```powershell
terraform plan -out=server.tfplan
terraform show server.tfplan
terraform apply server.tfplan
terraform output
```
Expect 1 add (instance only). Confirm the selected shape is compatible with the restored boot volume's OS/CPU architecture, approved subnet is correct, and NSGs/security policies have been reviewed. Validate server health and application requirements with owner; do not assume cloned hostname, SSH, agents or network settings are appropriate in a production-connected network.

## Cleanup - THREE SEPARATE, REVIEWED ACTIONS
**Get explicit approval.** Backup loss is irreversible. Never do `terraform destroy` indiscriminately.
1. Server first: set `create_server=false` but keep `create_restore=true`, `create_backup=true`. Temporarily change ONLY the `oci_core_instance.test_server` lifecycle `prevent_destroy` to `false` in `main.tf`. Run `terraform plan`, ensure **only** instance deletion, then `terraform apply`. Confirm instance TERMINATED and restored boot volume remains AVAILABLE; check `preserve_boot_volume = true`.
2. Restored volume second: keep `create_server=false`; set `create_restore=false`, `create_backup=true`; temporarily set ONLY `oci_core_boot_volume.restored` lifecycle `prevent_destroy=false`; plan and apply once the instance is detached/terminated and volume AVAILABLE. Confirm restored test volume TERMINATED.
3. Backup last: set all three flags false; temporarily set ONLY `oci_core_boot_volume_backup.backup` lifecycle `prevent_destroy=false`; plan and apply. Confirm BACKUP TERMINATED. Before step 3 verify no other restore/recovery depends on it.
4. Restore ALL THREE `prevent_destroy=true` protections, keep all flags false, and run `terraform state list` (should be empty). Confirm original source boot volume and original server remain intact in OCI.

**Important Terraform nuance:** `prevent_destroy` only guards a resource while its resource configuration exists with the lifecycle rule; never remove the entire block as a means of deleting it. This project uses `count` toggles and lifecycle checks, but test with `terraform plan` before changing flags. After using `count=0`, Terraform may not enforce protection on the removed instance; therefore, STOP at the plan if any unexpected destroy appears. For strongest protection, use explicit approval and isolate each stage. 

## Useful read-only verification
```powershell
terraform state list
terraform output
oci bv boot-volume get --boot-volume-id "SOURCE_OCID" --region ap-mumbai-1 --profile DEFAULT
oci bv boot-volume-backup get --boot-volume-backup-id "NEW_BACKUP_OCID" --region ap-mumbai-1 --profile DEFAULT
oci compute instance get --instance-id "NEW_INSTANCE_OCID" --region ap-mumbai-1 --profile DEFAULT
```
Validate `oci --help` syntax for your installed OCI CLI version.
