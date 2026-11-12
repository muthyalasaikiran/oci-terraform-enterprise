# MSK_sample UAT — Object Storage (independent Terraform state)

This add-on creates a **new private Standard bucket** and (optionally) a tiny text object. It does not modify pre-existing buckets. The names MUST be unique within the tenancy namespace and region. Do not choose an existing bucket name.

## Deploy

From `projects/MSK_sample/05-object-storage` in PowerShell:

```powershell
oci os ns get --region ap-mumbai-1 --profile DEFAULT --output json
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
code .\terraform.tfvars
terraform init
terraform validate
terraform providers
terraform plan
```

Set `namespace` to the `data` value returned by the CLI, and replace the sample bucket name suffix with a unique test value. Confirm the plan targets **only** `module.bucket.oci_objectstorage_bucket.this` and `oci_objectstorage_object.sample[0]` with `2 to add, 0 to change, 0 to destroy`. Do not apply until scope and access are reviewed.

After approval:

```powershell
terraform apply
terraform output
terraform state list
```

## Check using OCI CLI (read-only)

```powershell
oci os bucket get --namespace-name "YOUR_NAMESPACE" --name "YOUR_BUCKET" --region ap-mumbai-1 --profile DEFAULT
oci os object list --namespace-name "YOUR_NAMESPACE" --bucket-name "YOUR_BUCKET" --region ap-mumbai-1 --profile DEFAULT
```

## Controlled cleanup

Stop and ensure the test bucket contains **only** the Terraform-managed sample object and no real data or unrelated objects. Both resources have `prevent_destroy = true` initially. For approved test cleanup, change the `prevent_destroy` on `oci_objectstorage_object.sample` in this project's `main.tf` and the bucket module's `main.tf` to `false`, then run `terraform validate` and `terraform plan -destroy`. Check **exactly** the bucket and sample object will be destroyed. `terraform destroy` requires review and confirmation. Restore both protections to `true` afterward. **Do not delete state files.**

If the bucket contains any other objects or versions, stop and investigate. Versioning is disabled for this sample bucket. Avoid using this example for existing or production buckets without adapting policies and retention.

The FSS project remains separate in `04-file-storage`; do not run apply/destroy there as part of this test.
