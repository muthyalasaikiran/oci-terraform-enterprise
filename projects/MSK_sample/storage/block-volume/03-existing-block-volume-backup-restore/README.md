# Existing OCI Block Volume -> Backup -> Restore (MSK_sample)

This is the replacement for the OLD test workflow that *created* a source block volume. This project **does not create or manage the source volume**: `existing_volume_id` is referenced only as an input to the backup resource.

## Reuse across different servers, volumes, sizes

1. Identify the correct data block volume OCID (`ocid1.volume...`), not a boot volume, and verify its display name, compartment, availability domain and lifecycle state in OCI.
2. Use a **separate copied deployment directory and Terraform state for every independent volume/backup job**, especially when running jobs simultaneously. Never reuse a state directory for a different source until its managed backup/restore resources are deliberately cleaned up. Do not delete state to make it empty.
3. Copy `terraform.tfvars.example` to `terraform.tfvars`. Set `existing_volume_id`, source's compartment, desired restore AD, names, and performance (`restored_vpus_per_gb`). No `size_gb` input: OCI creates the restored volume with the backup's source size. Check capacity limits/costs for large restores.
4. Start with `create_backup=true`, `create_restore=false`; run `terraform init`, `terraform validate`, `terraform plan`. Plan should show only `oci_core_volume_backup.backup[0]` (1 add). Review and apply with authorization.
5. Wait until the OCI backup is `AVAILABLE` (`oci bv backup get --volume-backup-id "$(terraform output -raw backup_id)" --region ap-mumbai-1 --profile DEFAULT`).
6. Set `create_restore=true`; `terraform plan` should show only `oci_core_volume.restored[0]` (1 add). Review and apply. Confirm new volume AVAILABLE, separate OCID, correct size. It is NOT attached to a server.
7. All *managed* resources default to `prevent_destroy = true`. To clean up, use a controlled review and temporarily change ONLY this project's two resource lifecycle flags to `false`; run `terraform plan -destroy` and confirm only the newly-created backup and restored volume are targeted. Do not run destroy on another project's state; restore flags afterward. Backups/volumes may cost money while retained.

## Safety

- Terraform state here contains only the new backup and optional new restored volume; it never contains `oci_core_volume` for the existing source.
- For production/active filesystem volumes, coordinate application-consistent backups. Crash-consistent block backup alone may not ensure database/application recovery.
- OCI allows volume backups without detachment, but in-use writes may impact recoverability.
- The backup name must be unique enough for your operations; do not assume labels identify resources.
- Verify the selected source OCID every time. Access and IAM policies are still required.

## Example source (UAT — set only when authorized)

`SAMPLE-DATA-BV01` existing 200 GB volume:
`ocid1.volume.oc1.ap-mumbai-1.REPLACE`

## Retiring previous test project

The prior `projects/MSK_sample/06-block-volume-backup-restore` folder is NOT removed by extracting this add-on. Only after ALL three test resources are verified terminated in OCI AND its Terraform state is empty, you may archive or delete that old LOCAL directory. Removing a folder never destroys OCI resources and can lose state if resources remain.
