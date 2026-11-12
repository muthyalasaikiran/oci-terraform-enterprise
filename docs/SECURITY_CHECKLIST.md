# First push — security and quality checklist

- [ ] Repo owner/organization and **private** visibility approved for customer-specific material.
- [ ] `git status` and `git remote -v` checked; no existing history/remote overwritten.
- [ ] Current local `.tfstate` / `.tfvars` retained securely (not deleted) and excluded from Git.
- [ ] Existing `*.tfvars.example`, docs and README inspected for customer names, environment OCIDs, IPs, tenancy IDs, privileged details and passwords; sanitized or approved.
- [ ] `.terraform` provider binaries, `.zip` packages, SSH private keys, `.oci/config`, API keys and credentials excluded.
- [ ] Check `git diff --cached --name-only` AND inspect contents of staged files before committing.
- [ ] `.terraform.lock.hcl` reviewed and intentionally tracked; ensure provider namespaces/versions are correct.
- [ ] GitHub repo is not auto-deploying infrastructure.
- [ ] `prevent_destroy` safety settings restored after test cleanup; current source reviewed before publishing.
- [ ] `03-create-server-from-custom-image-ON-HOLD` still clearly marked on hold.
- [ ] If anything sensitive was ever committed, remove access immediately, rotate leaked credentials, and involve GitHub/admin/security for history cleaning; `.gitignore` does not erase history.

**Warning:** GitHub private status reduces exposure but is not authorization to put customer infrastructure identifiers into a third-party service. Follow company/customer policies.
