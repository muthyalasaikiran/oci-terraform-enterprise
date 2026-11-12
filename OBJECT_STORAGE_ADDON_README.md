# Object Storage add-on for existing `oci-terraform-reusable`

Extract into `C:\OCI_Terraform_Automation` (the archive includes the top folder `oci-terraform-reusable/`). **Merge** these new paths only; do not delete existing directories or Terraform state. Files are local examples only; no OCI operations are executed by extraction.

New files:
- `modules/object-storage/`: reusable private Standard bucket module (oracle/oci provider).
- `projects/MSK_sample/05-object-storage/`: independent project, sample object, configuration, and README.

No existing compute, block-volume, or FSS files are included in this archive. Need your tenancy Object Storage namespace (`oci os ns get`). Check IAM create/read/delete permissions in the target OCI compartment. Terraform plan and apply should be reviewed before execution.
