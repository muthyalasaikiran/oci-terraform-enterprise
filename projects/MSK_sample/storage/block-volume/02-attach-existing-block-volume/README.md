# MSK_sample standalone block-volume attachment

Uses shared `modules/volume-attachment`. This directory has a **separate Terraform state** from the compute and block-volume projects.

1. Check the instance is running and the block volume is AVAILABLE; both must be in the same availability domain.
2. Copy `terraform.tfvars.example` to `terraform.tfvars`. Set the actual **existing** instance OCID and volume OCID (outputs from their respective Terraform projects).
3. Run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.
4. Review that the plan creates **only** the attachment before running `terraform apply` after approval.
5. Verify attachment in OCI, then check the disk within the instance; Terraform does not partition, format, mount, or create filesystems.

The shared attachment module has `prevent_destroy = true`. Detachment needs a controlled approval and protection-change workflow. Never detach a mounted filesystem without coordinating with OS/app owners.
