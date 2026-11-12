# MSK_sample input checklist

Collect: OCI tenancy name/OCID (for profile verification; not required as a module input), region (`ap-mumbai-1`, etc.), compartment OCID, availability-domain **exact name**, subnet OCID, NSG OCIDs, shape and requested OCPU/RAM, image OCID (standard or custom) or **detached** boot-volume OCID, approved SSH public key file path, instance hostname, optional block-volume size/performance, preferred tagging and state backend details.

For all scenarios: confirm console shows correct project/compartment, image/boot volume compatible with shape and region, AD capacity and IAM policies. Use different state per project/environment/scenario. Deploy to UAT before production.

### Stage plan

1. Create new instance from platform image and optionally new block volume.
2. Validate server and guest OS, then test existing detached boot-volume creation flow *on a disposable copy*, never the production boot volume.
3. Validate instance from approved custom image, with correct launch mode and drivers.
4. Only after tests, standardize for other projects.
