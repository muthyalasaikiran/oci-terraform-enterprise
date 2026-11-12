# OCI Enterprise Reusable Terraform — MSK_sample Baseline

> **Internal / company-approved access only.** Terraform code for OCI compute, block volumes, file storage and object storage. **Never commit OCI credentials, `.tfstate`, real `.tfvars` or customer-sensitive network details.**

## Purpose

Use this repository to version reusable OCI Terraform modules and project-specific root configurations, document each input, review changes in GitHub, and repeat approved provisioning/cleanup workflows. **GitHub stores source code and documentation, not live Terraform state or OCI resources.** Git pushes do not run `terraform apply`.

## Get started (Windows PowerShell)

1. Work in the actual leaf project folder; **do not run Terraform from the repository root or the `modules` folder**.
2. Ensure Terraform and OCI CLI are installed; verify the OCI profile and environment permissions.
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and replace placeholders with approved *environment-specific* inputs. Never commit real `terraform.tfvars`.
4. Run `terraform init`, `terraform validate`, `terraform state list`, and `terraform plan -out=create.tfplan`. Review exact additions/updates/deletions and dependencies.
5. Only after change approval, run `terraform apply .\create.tfplan`. Verify in the OCI Console and with `terraform state list` / `terraform output`.
6. For cleanup, check usage/data retention/approval, preview the precise deletion, and restore any temporarily changed `prevent_destroy` settings.

Example (Object Storage project):

```powershell
cd 'C:\OCI_Terraform_Automation\Enterprise_Preview\oci-terraform-reusable\projects\MSK_sample\storage\object-storage\01-create-bucket'
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
code .\terraform.tfvars
terraform init
terraform validate
terraform state list
terraform plan -input=false -out=create.tfplan
terraform show -no-color .\create.tfplan
# With explicit approval only: terraform apply .\create.tfplan
```

## Where everything is

| Location | Purpose |
|---|---|
| `modules/compute/` | Shared compute / multi-server modules |
| `modules/storage/` | Shared block volume, backup/restore, FSS, export, mount target and Object Storage modules |
| `projects/MSK_sample/compute/` | Six independent compute activities |
| `projects/MSK_sample/storage/block-volume/` | Create volume, attach volume, and backup/restore |
| `projects/MSK_sample/storage/file-storage/` | Create FSS, Mount Target and Export |
| `projects/MSK_sample/storage/object-storage/` | Create private test bucket and optional sample object |
| `docs/PROJECT_INPUTS.md` | **Every current MSK_sample project input**, type/default/meaning and instructions |
| `docs/MODULE_INPUTS.md` | **All 12 reusable module inputs** and current defaults |
| `docs/GITHUB_SETUP.md` | GitHub creation, Git commands, commit/push/pull, branches and reviews |
| `docs/OPERATIONS_AND_SAFETY.md` | How to test and clean up correctly, including `prevent_destroy` |
| `docs/SECURITY_CHECKLIST.md` | Pre-push checklist; how to avoid leaking credentials and state |
| `docs/ACTIVITY_STATUS.md` | Observed test results and remaining verification items |

### MSK_sample activity folders

- [`01-create-server-and-optional-block-volume`](projects/MSK_sample/compute/01-create-server-and-optional-block-volume/README.md) — `projects/MSK_sample/compute/01-create-server-and-optional-block-volume`
- [`02-create-server-from-existing-boot-volume`](projects/MSK_sample/compute/02-create-server-from-existing-boot-volume/README.md) — `projects/MSK_sample/compute/02-create-server-from-existing-boot-volume`
- [`03-create-server-from-custom-image-ON-HOLD`](projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD/README.md) — `projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD`
- [`04-boot-backup-restore-create-server`](projects/MSK_sample/compute/04-boot-backup-restore-create-server/README.md) — `projects/MSK_sample/compute/04-boot-backup-restore-create-server`
- [`05-multiple-servers-for-each`](projects/MSK_sample/compute/05-multiple-servers-for-each/README.md) — `projects/MSK_sample/compute/05-multiple-servers-for-each`
- [`06-multiple-servers-count`](projects/MSK_sample/compute/06-multiple-servers-count/README.md) — `projects/MSK_sample/compute/06-multiple-servers-count`
- [`01-create-block-volume`](projects/MSK_sample/storage/block-volume/01-create-block-volume/README.md) — `projects/MSK_sample/storage/block-volume/01-create-block-volume`
- [`02-attach-existing-block-volume`](projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume/README.md) — `projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume`
- [`03-existing-block-volume-backup-restore`](projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore/README.md) — `projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore`
- [`01-create-fss-mount-target-export`](projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export/README.md) — `projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export`
- [`01-create-bucket`](projects/MSK_sample/storage/object-storage/01-create-bucket/README.md) — `projects/MSK_sample/storage/object-storage/01-create-bucket`

## Code review and state management

- Make changes on a feature branch, open a pull request for review, then merge to `main` after approval.
- Keep **one separate Terraform state per leaf project and per environment**; never commit state to GitHub.
- The local working directory may already manage live resources. **Do not delete, clone over, or move Terraform states** just to start version control.
- `prevent_destroy` protects OCI resources from accidental deletion, but is not a substitute for backups or change approval.
- Existing production-named/shared resources require explicit approval for attachment, detachment, startup or modification.
- The custom-image example remains **ON HOLD**. Do not infer that all compute cases have passed testing.

See [GitHub setup](docs/GITHUB_SETUP.md), [all project inputs](docs/PROJECT_INPUTS.md), and [security checklist](docs/SECURITY_CHECKLIST.md) before your first push.
