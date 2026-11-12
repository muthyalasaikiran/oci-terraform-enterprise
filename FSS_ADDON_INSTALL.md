# FSS drop-in package for MSK_sample reusable Terraform

Extract this ZIP into `C:\OCI_Terraform_Automation` so that the ZIP's `oci-terraform-reusable/` folder merges with your existing directory. **Do not replace/delete the entire repository.** Only these NEW paths are supplied:

- modules/file-storage
- modules/mount-target
- modules/fss-export
- projects/MSK_sample/04-file-storage

The previous compute, block-volume and attachment projects are **not included and are not touched**. If you already created any of these FSS files manually, compare before overwriting them.

Open `projects/MSK_sample/04-file-storage/README.md` and `terraform.tfvars.example`. Do not run `terraform apply` until the mount-target subnet, NSGs and export permissions have been reviewed.
