# MSK_sample: 02-from-boot-volume

Source mode: `bootVolume`. Supply detached existing boot volume ocid. For a boot-volume launch, the volume must be detached, compatible with the new shape, and in the appropriate availability domain. Never point to a boot volume still attached to a running server.

1. Copy `terraform.tfvars.example` to `terraform.tfvars`, then fill in real OCIDs, region/AD, and the public SSH key file path. Check quotas, compatibility, network/NSG and permissions.
2. Authenticate using the OCI CLI config (`~/.oci/config`) or OCI supported environment variables. Confirm the right tenancy and profile.
3. Run `terraform init`, `terraform fmt -check`, `terraform validate`, `terraform plan -out=tfplan`, review all changes, then `terraform apply tfplan`.
4. Save state securely and back it up. For team usage configure a **separate remote backend/state key per project and scenario** before applying. Never commit state or tfvars with secrets.
5. On the guest, inspect disk paths (`lsblk -f`) before creating filesystems or mounting disks; Terraform only attaches the volume.

**Safeguards:** instances and volumes have `prevent_destroy = true`. Never remove this for production without an approved migration/change. Existing boot volume launches are not equivalent to copying a boot volume; the given volume is the boot source of the new instance.
