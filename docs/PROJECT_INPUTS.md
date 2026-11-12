# MSK_sample Terraform — Input Reference (All Existing Projects)

This is an inventory of **variable names** read from the Enterprise Preview package's existing `projects/MSK_sample/**/variables.tf` files. Use your **current local files as the source of truth** if anything has changed since that package was copied. Values are environment-specific; examples must be sanitized before sharing.

**Do not put real OCI IDs, private IPs, keys, passwords, customer names or secrets into GitHub examples without company approval.** A private GitHub repository is still shared with its permitted members.

## Inputs common to many projects

- `region`: `ap-mumbai-1` or another approved region.
- `compartment_id`: target resource compartment OCID; check console selection before applying.
- `availability_domain`: match the exact value from OCI CLI; not a generic `AD-1` placeholder.
- `subnet_id` / `mount_target_subnet_id`: approved subnet; cross-compartment network use requires IAM and network approval.
- `nsg_ids` / `mount_target_nsg_ids`: OCI NSG OCIDs (list syntax `["ocid1...."]`).
- `oci_profile`: OCI local config profile; verify with OCI CLI.
- `tags` / `freeform_tags`: identify project, environment, ownership.
- Boolean toggles (`create_*`, `upload_sample_object`): they control Terraform resource count; switching from `true` to `false` **can propose destruction**. Always inspect `terraform plan`.

**Generic PowerShell recipe from any project folder:**

```powershell
Copy-Item .\terraform.tfvars.example .\terraform.tfvars
code .\terraform.tfvars
terraform init
terraform validate
terraform state list
terraform plan -input=false
```

The table's **Required** column means *no `default` was declared in that variable block*; it does not imply it must always be set in `terraform.tfvars` if provided another way. Defaults are current-source defaults, not recommended production settings.

## `projects/MSK_sample/compute/01-create-server-and-optional-block-volume`

[Workflow README](../projects/MSK_sample/compute/01-create-server-and-optional-block-volume/README.md) · [Example inputs](../projects/MSK_sample/compute/01-create-server-and-optional-block-volume/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `subnet_id` | `string` | **Required** | Approved subnet OCID for compute instance VNIC. |
| `instance_name` | `string` | **Required** | New compute instance display name. |
| `shape` | `string` | **Required** | Compatible OCI VM shape. |
| `shape_ocpus` | `number` | Default: `null` | OCPUs for flex shape. |
| `shape_memory_gbs` | `number` | Default: `null` | Memory in GB for flex shape. |
| `source_id` | `string` | **Required** | Platform-image/custom-image OCID, or existing detached boot volume OCID according to workflow. |
| `ssh_public_key_path` | `string` | Default: `null` | Local path to authorized **public** SSH key (`.pub`), never private key. |
| `nsg_ids` | `list(string)` | Default: `[]` | List of approved network security group OCIDs. |
| `assign_public_ip` | `bool` | Default: `false` | Whether an instance VNIC gets public IPv4; generally false for private UAT. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |
| `create_data_volume` | `bool` | Default: `false` | Whether to create extra block volume with the server. |
| `data_volume_name` | `string` | Default: `"msk-sample-data"` | Display name of optional data block volume. |
| `data_volume_size_gb` | `number` | Default: `100` | Requested volume size in GB. |
| `data_volume_vpus_per_gb` | `number` | Default: `10` | Block volume performance in VPUs/GB. |

## `projects/MSK_sample/compute/02-create-server-from-existing-boot-volume`

[Workflow README](../projects/MSK_sample/compute/02-create-server-from-existing-boot-volume/README.md) · [Example inputs](../projects/MSK_sample/compute/02-create-server-from-existing-boot-volume/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `subnet_id` | `string` | **Required** | Approved subnet OCID for compute instance VNIC. |
| `instance_name` | `string` | **Required** | New compute instance display name. |
| `shape` | `string` | **Required** | Compatible OCI VM shape. |
| `shape_ocpus` | `number` | Default: `null` | OCPUs for flex shape. |
| `shape_memory_gbs` | `number` | Default: `null` | Memory in GB for flex shape. |
| `source_id` | `string` | **Required** | Platform-image/custom-image OCID, or existing detached boot volume OCID according to workflow. |
| `ssh_public_key_path` | `string` | Default: `null` | Local path to authorized **public** SSH key (`.pub`), never private key. |
| `nsg_ids` | `list(string)` | Default: `[]` | List of approved network security group OCIDs. |
| `assign_public_ip` | `bool` | Default: `false` | Whether an instance VNIC gets public IPv4; generally false for private UAT. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |
| `create_data_volume` | `bool` | Default: `false` | Whether to create extra block volume with the server. |
| `data_volume_name` | `string` | Default: `"msk-sample-data"` | Display name of optional data block volume. |
| `data_volume_size_gb` | `number` | Default: `100` | Requested volume size in GB. |
| `data_volume_vpus_per_gb` | `number` | Default: `10` | Block volume performance in VPUs/GB. |

## `projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD`

[Workflow README](../projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD/README.md) · [Example inputs](../projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `subnet_id` | `string` | **Required** | Approved subnet OCID for compute instance VNIC. |
| `instance_name` | `string` | **Required** | New compute instance display name. |
| `shape` | `string` | **Required** | Compatible OCI VM shape. |
| `shape_ocpus` | `number` | Default: `null` | OCPUs for flex shape. |
| `shape_memory_gbs` | `number` | Default: `null` | Memory in GB for flex shape. |
| `source_id` | `string` | **Required** | Platform-image/custom-image OCID, or existing detached boot volume OCID according to workflow. |
| `ssh_public_key_path` | `string` | Default: `null` | Local path to authorized **public** SSH key (`.pub`), never private key. |
| `nsg_ids` | `list(string)` | Default: `[]` | List of approved network security group OCIDs. |
| `assign_public_ip` | `bool` | Default: `false` | Whether an instance VNIC gets public IPv4; generally false for private UAT. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |
| `create_data_volume` | `bool` | Default: `false` | Whether to create extra block volume with the server. |
| `data_volume_name` | `string` | Default: `"msk-sample-data"` | Display name of optional data block volume. |
| `data_volume_size_gb` | `number` | Default: `100` | Requested volume size in GB. |
| `data_volume_vpus_per_gb` | `number` | Default: `10` | Block volume performance in VPUs/GB. |

## `projects/MSK_sample/compute/04-boot-backup-restore-create-server`

[Workflow README](../projects/MSK_sample/compute/04-boot-backup-restore-create-server/README.md) · [Example inputs](../projects/MSK_sample/compute/04-boot-backup-restore-create-server/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | Default: `"ap-mumbai-1"` | OCI target region, e.g., `ap-mumbai-1`. |
| `oci_profile` | `string` | Default: `"DEFAULT"` | OCI CLI config profile, usually `DEFAULT`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `source_boot_volume_id` | `string` | **Required** | OCID of approved source boot volume for FULL backup. |
| `backup_name` | `string` | **Required** | Name of new backup. |
| `restored_boot_volume_name` | `string` | **Required** | Name of new volume restored from boot backup. |
| `new_server_name` | `string` | **Required** | Name for a new instance created from restored boot volume. |
| `subnet_id` | `string` | Default: `""` | Approved subnet OCID for compute instance VNIC. |
| `shape` | `string` | Default: `"VM.Standard.E4.Flex"` | Compatible OCI VM shape. |
| `ocpus` | `number` | Default: `1` | OCPU count for selected shape. |
| `memory_in_gbs` | `number` | Default: `8` | Memory amount in GB. |
| `ssh_authorized_keys` | `string` | Default: `""` | SSH *public key content* for authorized access, never private key content. |
| `create_backup` | `bool` | Default: `false` | Boolean: whether to create backup (`true`/`false`). |
| `create_restore` | `bool` | Default: `false` | Boolean: whether to create restored volume (`true`/`false`). |
| `create_server` | `bool` | Default: `false` | Boolean: whether to create server from restored boot volume. |
| `freeform_tags` | `map(string)` | Default: `{} / map` | OCI freeform tags. |
| `private_ip` | `string` | Default: `null` | Specific approved unused private IP; validate subnet/availability. |

## `projects/MSK_sample/compute/05-multiple-servers-for-each`

[Workflow README](../projects/MSK_sample/compute/05-multiple-servers-for-each/README.md) · [Example inputs](../projects/MSK_sample/compute/05-multiple-servers-for-each/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `(not declared)` | Default: `"ap-mumbai-1"` | OCI target region, e.g., `ap-mumbai-1`. |
| `oci_profile` | `(not declared)` | Default: `"DEFAULT"` | OCI CLI config profile, usually `DEFAULT`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `subnet_id` | `string` | **Required** | Approved subnet OCID for compute instance VNIC. |
| `image_id` | `string` | **Required** | Compatible OCI image OCID. |
| `ssh_public_key_path` | `string` | Default: `null` | Local path to authorized **public** SSH key (`.pub`), never private key. |
| `nsg_ids` | `list(string)` | Default: `[]` | List of approved network security group OCIDs. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |
| `servers` | `map(object({` | Default: `{} / map` | Map keyed by stable server names; each entry configures shape/OCPUs/memory/IP. Review `.tfvars.example`. |

## `projects/MSK_sample/compute/06-multiple-servers-count`

[Workflow README](../projects/MSK_sample/compute/06-multiple-servers-count/README.md) · [Example inputs](../projects/MSK_sample/compute/06-multiple-servers-count/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `(not declared)` | Default: `"ap-mumbai-1"` | OCI target region, e.g., `ap-mumbai-1`. |
| `oci_profile` | `(not declared)` | Default: `"DEFAULT"` | OCI CLI config profile, usually `DEFAULT`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `subnet_id` | `string` | **Required** | Approved subnet OCID for compute instance VNIC. |
| `image_id` | `string` | **Required** | Compatible OCI image OCID. |
| `ssh_public_key_path` | `string` | Default: `null` | Local path to authorized **public** SSH key (`.pub`), never private key. |
| `nsg_ids` | `list(string)` | Default: `[]` | List of approved network security group OCIDs. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |
| `server_count` | `number` | Default: `0` | Number of servers for `count` workflow; starts at zero. |
| `name_prefix` | `(not declared)` | Default: `"MSK-TF-UAT-COUNT"` | Naming prefix for `count` servers. |
| `shape` | `(not declared)` | Default: `"VM.Standard.E5.Flex"` | Compatible OCI VM shape. |
| `ocpus` | `(not declared)` | Default: `1` | OCPU count for selected shape. |
| `memory_in_gbs` | `(not declared)` | Default: `8` | Memory amount in GB. |
| `private_ips` | `list(string)` | Default: `[]` | List of approved unique private IPs in desired index order. |

## `projects/MSK_sample/storage/block-volume/01-create-block-volume`

[Workflow README](../projects/MSK_sample/storage/block-volume/01-create-block-volume/README.md) · [Example inputs](../projects/MSK_sample/storage/block-volume/01-create-block-volume/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `volume_name` | `string` | **Required** | New block volume display name. |
| `size_gb` | `number` | **Required** | Block volume capacity in GB. |
| `vpus_per_gb` | `number` | Default: `10` | Volume performance tier expressed in VPUs/GB. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |

## `projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume`

[Workflow README](../projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume/README.md) · [Example inputs](../projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `instance_id` | `string` | **Required** | OCID of approved existing compute instance to attach to. |
| `volume_id` | `string` | **Required** | OCID of an existing data block volume to attach. |
| `attachment_name` | `string` | **Required** | Display label for test attachment. |
| `attachment_type` | `string` | Default: `"paravirtualized"` | Attachment mode, e.g. `paravirtualized`. |

## `projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore`

[Workflow README](../projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore/README.md) · [Example inputs](../projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `existing_volume_id` | `string` | **Required** | Source block volume OCID to back up, not deleted by this workflow. |
| `backup_name` | `string` | **Required** | Name of new backup. |
| `backup_type` | `string` | Default: `"FULL"` | Backup type, e.g. `FULL`. |
| `restored_volume_name` | `string` | **Required** | New volume name for restore. |
| `restored_vpus_per_gb` | `number` | Default: `10` | Performance for restored volume. |
| `create_backup` | `bool` | Default: `true` | Boolean: whether to create backup (`true`/`false`). |
| `create_restore` | `bool` | Default: `false` | Boolean: whether to create restored volume (`true`/`false`). |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |

## `projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export`

[Workflow README](../projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export/README.md) · [Example inputs](../projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `availability_domain` | `string` | **Required** | Exact OCI Availability Domain name; verify region and placement. |
| `file_system_name` | `string` | **Required** | Display name for new FSS File System. |
| `mount_target_name` | `string` | **Required** | Display name for new Mount Target. |
| `mount_target_subnet_id` | `string` | **Required** | Approved subnet OCID for new FSS Mount Target; verify free IPs. |
| `mount_target_nsg_ids` | `list(string)` | **Required** | Approved NSG OCID list for NFS Mount Target. |
| `export_path` | `string` | **Required** | Unique NFS export path, e.g. `/msk-sample`. |
| `client_cidr` | `string` | **Required** | Allowed NFS client CIDR; verify real test client, use /32 for approved single host. |
| `export_access` | `string` | Default: `"READ_ONLY"` | `READ_ONLY` or `READ_WRITE` as approved. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |

## `projects/MSK_sample/storage/object-storage/01-create-bucket`

[Workflow README](../projects/MSK_sample/storage/object-storage/01-create-bucket/README.md) · [Example inputs](../projects/MSK_sample/storage/object-storage/01-create-bucket/terraform.tfvars.example)

| Input | Type | Required / default | Purpose |
|---|---|---|---|
| `region` | `string` | **Required** | OCI target region, e.g., `ap-mumbai-1`. |
| `compartment_id` | `string` | **Required** | Approved target compartment OCID. |
| `namespace` | `string` | **Required** | Tenancy Object Storage namespace from `oci os ns get`. |
| `bucket_name` | `string` | **Required** | New unique bucket name; never reuse a live bucket name. |
| `upload_sample_object` | `bool` | Default: `true` | Whether sample file is uploaded (true/false). |
| `sample_object_name` | `string` | Default: `"terraform-tests/test-upload.txt"` | Name of object within bucket, e.g. `terraform-tests/test-upload.txt`. |
| `tags` | `map(string)` | Default: `{} / map` | Free-form resource tags for ownership, project, environment. |

## Example configuration and execution notes

### Creating a private Object Storage bucket (sanitized example)

```hcl
region               = "ap-mumbai-1"
compartment_id       = "REPLACE_WITH_APPROVED_COMPARTMENT_OCID"
namespace            = "REPLACE_WITH_TENANCY_NAMESPACE"
bucket_name          = "msk-sample-tf-uat-obj-test01-UNIQUE"
upload_sample_object = true
sample_object_name   = "terraform-tests/test-upload.txt"
tags = { project = "MSK_sample", environment = "uat", managed_by = "terraform" }
```

Get the namespace: `oci os ns get --region ap-mumbai-1 --profile DEFAULT --query 'data' --raw-output`. The bucket and test object are independent Terraform resources and have `prevent_destroy` protection in their modules; cleanup requires a reviewed, approved deletion plan. Remove the object first, then the bucket.

### FSS provisioning-only test (do not use application client IPs without approval)

- Confirm a new file-system name, new mount-target name, approved subnet/NSGs, AD and distinct export path.
- `client_cidr` controls which NFS clients *could* access the new export; it does not automatically mount or modify any server.
- For a provisioning-only test with no NFS client, keep client access deliberately restricted and network-approved. Do not claim a functional NFS mount test was performed.

### Multi-server precautions

- For `for_each`, server names are stable map keys; removing one key targets that server.
- For `count`, reducing count can destroy highest indexes; changing list/index order may cause unintended changes. Always preview before applying.

### Backup/restore precautions

- Block and boot volume backups are not the same as moving a running OS disk.
- Confirm source IDs, AD, compartment and application-consistent backup requirements.
- Do not detach a running OS boot volume or mount/format a production disk without an approved runbook.
