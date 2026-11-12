# MSK_sample standalone block volume

Uses shared `modules/block-volume`. This directory has a **separate Terraform state** from compute and attachment.

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and review the target compartment, AD, size, and tags.
2. Run `terraform init`, `terraform fmt`, `terraform validate`, and `terraform plan`.
3. After authorization, `terraform apply` creates just one volume.
4. Record `terraform output -raw volume_id` to use in the attachment project.

The shared module has `prevent_destroy = true`. Do not turn off protection on a volume with data; test cleanup must be separately reviewed. The volume is not attached, formatted, or mounted by this project.
