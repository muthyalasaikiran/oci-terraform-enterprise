# OCI Enterprise Terraform - Customer Deployment Guide

## 1. Overview

This repository provides 12 reusable OCI Terraform modules and 11 sample deployment workflows under projects/MSK_sample.

The modules support compute provisioning, boot volume operations, block volumes, volume attachments, file storage, and object storage.

IMPORTANT: The custom-image workflow is ON HOLD. Terraform syntax validation does not mean this workflow is approved for deployment.

## 2. Prerequisites

- Terraform installed on the administrator workstation.
- OCI account and authorized IAM permissions.
- OCI CLI profile or another approved OCI provider authentication method.
- Correct target OCI region and compartment.
- Existing network and subnet resources where required.
- Approved resource naming and tagging standards.
- Change approval before provisioning or deleting infrastructure.
- Approved Terraform state backend and access controls for team use.

## 3. Available Workflows

### Compute
1. Create server from platform image with optional block volume.
2. Create server from existing boot volume.
3. Create server from custom image (ON HOLD).
4. Back up existing boot volume, restore, and create server.
5. Create multiple servers using for_each.
6. Create multiple servers using count.

### Storage
7. Create standalone block volume.
8. Attach existing block volume to an instance.
9. Back up and restore existing block volume.
10. Create file system, mount target, and export.
11. Create Object Storage bucket with optional sample object.

## 4. Configure a Workflow

Choose one workflow folder under projects/MSK_sample.

Read the README.md and variables.tf for that workflow.

Copy terraform.tfvars.example to terraform.tfvars.

Replace all placeholders with values approved for your OCI environment, including:

- Region
- Compartment OCID
- Availability domain
- VCN and subnet OCIDs
- Network security group OCIDs
- Image or boot volume OCID
- Instance shape, OCPU and memory
- SSH public key
- Storage resource names and sizes
- Application tags

Not all values apply to every workflow.

Never commit actual terraform.tfvars files, API private keys, or Terraform state.

## 5. Standard Terraform Commands

Run from the selected workflow directory:

    terraform fmt -check
    terraform init
    terraform validate
    terraform plan -out=tfplan
    terraform show tfplan

Review the plan and obtain approval before deployment.

After approval:

    terraform apply tfplan

Terraform state must be stored securely. Use a suitable shared state backend and locking mechanism for team operations.

## 6. Post-Deployment Verification

- Verify the resource exists in the correct OCI compartment and region.
- Confirm resource state and configuration.
- Validate network connectivity where applicable.
- Confirm expected block volume attachment or file system export.
- Record outputs and change ticket information.

## 7. Cleanup and Rollback

Never run terraform destroy without approval.

Before any deletion:

- Identify all resources in the Terraform state.
- Confirm that no existing customer resources will be affected.
- Review the full Terraform destruction plan.
- Check lifecycle prevent_destroy protections.
- Confirm backup, retention, and recovery requirements.
- Follow dependency order for attachments, backups and storage.

A successful terraform destroy is not necessarily a rollback of application data.

## 8. Additional Documentation

- docs/PROJECT_INPUTS.md
- docs/MODULE_INPUTS.md
- docs/OPERATIONS_AND_SAFETY.md
- docs/SECURITY_CHECKLIST.md
- Each workflow's README.md
- Each workflow's terraform.tfvars.example

## 9. Security

Deploy only to authorized environments.

Never publish customer identifiers, internal network details, authentication secrets, or sensitive Terraform state.

Review repository visibility and code-sharing permissions before providing access to customers.
