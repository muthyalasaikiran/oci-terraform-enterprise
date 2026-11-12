# OCI reusable modules — exact input variables

Module variables are passed from the leaf root `projects/MSK_sample/.../main.tf`; **do not run `terraform apply` from a module folder**. This reference is based on the supplied Enterprise Preview source snapshot; confirm current local module `variables.tf` if changed.

Shared modules are meant to be reused from approved root configurations.

## `compute/compute`

| Variable | Type | Required/default |
|---|---|---|
| `name` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `availability_domain` | `string` | **Required** |
| `subnet_id` | `string` | **Required** |
| `shape` | `string` | **Required** |
| `source_type` | `string` | **Required** |
| `source_id` | `string` | **Required** |
| `shape_ocpus` | `number` | `null` |
| `shape_memory_gbs` | `number` | `null` |
| `assign_public_ip` | `bool` | `false` |
| `nsg_ids` | `list(string)` | `[]` |
| `hostname_label` | `string` | `null` |
| `ssh_public_key_path` | `string` | `null` |
| `tags` | `map(string)` | `{}` |

## `compute/multi-server-instance`

| Variable | Type | Required/default |
|---|---|---|
| `name` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `availability_domain` | `string` | **Required** |
| `subnet_id` | `string` | **Required** |
| `shape` | `string` | **Required** |
| `image_id` | `string` | **Required** |
| `ocpus` | `number` | **Required** |
| `memory_in_gbs` | `number` | **Required** |
| `private_ip` | `string` | `null` |
| `nsg_ids` | `list(string)` | `[]` |
| `ssh_public_key_path` | `string` | `null` |
| `tags` | `map(string)` | `{}` |

## `storage/block-volume`

| Variable | Type | Required/default |
|---|---|---|
| `name` | `string` | **Required** |
| `availability_domain` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `size_gb` | `number` | **Required** |
| `vpus_per_gb` | `number` | `10` |
| `tags` | `map(string)` | `{}` |

## `storage/block-volume-backup`

| Variable | Type | Required/default |
|---|---|---|
| `volume_id` | `string` | **Required** |
| `name` | `string` | **Required** |
| `backup_type` | `string` | `"FULL"` |
| `tags` | `map(string)` | `{}` |

## `storage/block-volume-restore`

| Variable | Type | Required/default |
|---|---|---|
| `availability_domain` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `name` | `string` | **Required** |
| `backup_id` | `string` | **Required** |
| `vpus_per_gb` | `number` | `10` |
| `tags` | `map(string)` | `{}` |

## `storage/boot-volume-backup`

| Variable | Type | Required/default |
|---|---|---|
| `source_boot_volume_id` | `string` | **Required** |
| `display_name` | `string` | **Required** |
| `freeform_tags` | `map(string)` | `{}` |

## `storage/boot-volume-restore`

| Variable | Type | Required/default |
|---|---|---|
| `availability_domain` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `display_name` | `string` | **Required** |
| `backup_id` | `string` | **Required** |
| `freeform_tags` | `map(string)` | `{}` |

## `storage/file-storage`

| Variable | Type | Required/default |
|---|---|---|
| `availability_domain` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `name` | `string` | **Required** |
| `tags` | `map(string)` | `{}` |

## `storage/fss-export`

| Variable | Type | Required/default |
|---|---|---|
| `export_set_id` | `string` | **Required** |
| `file_system_id` | `string` | **Required** |
| `path` | `string` | **Required** |
| `client_cidr` | `string` | **Required** |
| `access` | `string` | `"READ_ONLY"` |

## `storage/mount-target`

| Variable | Type | Required/default |
|---|---|---|
| `availability_domain` | `string` | **Required** |
| `compartment_id` | `string` | **Required** |
| `subnet_id` | `string` | **Required** |
| `name` | `string` | **Required** |
| `nsg_ids` | `list(string)` | `[]` |
| `tags` | `map(string)` | `{}` |

## `storage/object-storage`

| Variable | Type | Required/default |
|---|---|---|
| `compartment_id` | `string` | **Required** |
| `namespace` | `string` | **Required** |
| `name` | `string` | **Required** |
| `tags` | `map(string)` | `{}` |

## `storage/volume-attachment`

| Variable | Type | Required/default |
|---|---|---|
| `name` | `string` | **Required** |
| `instance_id` | `string` | **Required** |
| `volume_id` | `string` | **Required** |
| `attachment_type` | `string` | `"paravirtualized"` |

## Change control

- When changing a shared module, identify all project callers before committing; a module update can affect multiple environments at their next Terraform plan/apply.
- Avoid changing `prevent_destroy` for anything except an approved disposable cleanup, and restore protections after the test.
- Review `terraform providers` in each root before provider upgrades; do not automatically run `terraform init -upgrade`.
