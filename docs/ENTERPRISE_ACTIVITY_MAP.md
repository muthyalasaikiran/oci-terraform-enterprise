# MSK_sample Enterprise activity map

| Service | Activity (separate Terraform state) | Previous folder | New folder |
|---|---|---|---|
| compute | 01-create-server-and-optional-block-volume | `projects/MSK_sample/01-new-instance` | `projects/MSK_sample/compute/01-create-server-and-optional-block-volume` |
| compute | 02-create-server-from-existing-boot-volume | `projects/MSK_sample/02-from-boot-volume` | `projects/MSK_sample/compute/02-create-server-from-existing-boot-volume` |
| compute | 03-create-server-from-custom-image-ON-HOLD | `projects/MSK_sample/03-from-custom-image` | `projects/MSK_sample/compute/03-create-server-from-custom-image-ON-HOLD` |
| compute | 04-boot-backup-restore-create-server | `projects/MSK_sample/07-existing-boot-volume-backup-restore-create-server` | `projects/MSK_sample/compute/04-boot-backup-restore-create-server` |
| compute | 05-multiple-servers-for-each | `projects/MSK_sample/09-multiple-servers-for-each` | `projects/MSK_sample/compute/05-multiple-servers-for-each` |
| compute | 06-multiple-servers-count | `projects/MSK_sample/10-multiple-servers-count` | `projects/MSK_sample/compute/06-multiple-servers-count` |
| storage | 01-create-block-volume | `projects/MSK_sample/02-create-block-volume` | `projects/MSK_sample/storage/block-volume/01-create-block-volume` |
| storage | 02-attach-existing-block-volume | `projects/MSK_sample/03-attach-block-volume` | `projects/MSK_sample/storage/block-volume/02-attach-existing-block-volume` |
| storage | 03-existing-block-volume-backup-restore | `projects/MSK_sample/06-existing-volume-backup-restore` | `projects/MSK_sample/storage/block-volume/03-existing-block-volume-backup-restore` |
| storage | 01-create-fss-mount-target-export | `projects/MSK_sample/04-file-storage` | `projects/MSK_sample/storage/file-storage/01-create-fss-mount-target-export` |
| storage | 01-create-bucket | `projects/MSK_sample/05-object-storage` | `projects/MSK_sample/storage/object-storage/01-create-bucket` |

## Operating principle

Use the workflow folder for its complete create → verify → cleanup sequence. Related workflows live next to each other; distinct activities intentionally retain distinct state to prevent accidental cross-deletion. `for_each` and `count` are separate demos because their resource addresses differ.

**Note:** The custom-image example deploys from an existing image; it does not create an OCI custom image from a running server. That activity remains on hold.

**Note:** A live FSS export should be verified from an approved Linux client before calling the NFS mount activity complete.
