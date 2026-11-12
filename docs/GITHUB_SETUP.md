# GitHub setup & daily version-control guide (Windows PowerShell)

> Use a **company-approved PRIVATE repository** and correct access controls. This document publishes **source code**, not real infrastructure. Do not upload existing local state or active environment config.

## 1. Preflight at the correct root

```powershell
cd "C:\OCI_Terraform_Automation\Enterprise_Preview\oci-terraform-reusable"
git --version
git status
git remote -v
```

If Git is not installed, install Git for Windows from https://git-scm.com/download/win and reopen PowerShell. If `git status` works, **do not reinitialize or change the remote until you've reviewed it**.

Before installing the supplied docs pack, save copies of existing `README.md` and `.gitignore` (the pack updates both). `Expand-Archive` should run only with the archive explicitly downloaded to your machine and inside the repository root.

## 2. Repository contents / what not to upload

Commit: `.tf`, sanitized `*.tfvars.example`, `.terraform.lock.hcl` (provider pins), module/source documentation, test sample text files, READMEs. Do NOT commit: `.terraform/`, `*.tfstate*`, `terraform.tfvars`, `*.tfplan`, OCI config/keys, passwords, logs and provider binaries. **Do not upload the huge Enterprise_Preview ZIP; it can contain cached providers and stale state.**

Run these checks **before staging**:

```powershell
git status --short
Get-ChildItem -Path . -Recurse -Force -File -Include 'terraform.tfstate*','terraform.tfvars','*.tfplan','*.pem','*.key' |
    Select-Object -ExpandProperty FullName
```

This inventory deliberately reveals files on disk; their presence is expected in a working directory. The question is whether any are staged or tracked. Do not manually delete state or config files. Review/sanitize *every* `terraform.tfvars.example` and `.md` for customer-sensitive values before adding to Git.

## 3. Initialize Git only if needed

If `git status` reported **not a git repository**:

```powershell
git init -b main
```

Configure commit identity once (use your authorized business identity):

```powershell
git config --global user.name "YOUR APPROVED GIT NAME"
git config --global user.email "YOUR_APPROVED_EMAIL@example.com"
```

## 4. Stage safely, REVIEW before commit

```powershell
git add .
git status --short
git diff --cached --name-only
```

**Stop** if you see any real `terraform.tfvars`, `.tfstate`, secrets, `.pem`/private keys, downloaded providers, `.zip`, or unexpected customer content. To unstage everything without deleting your work:

```powershell
git restore --staged .
```

To check a particular excluded file, use `git check-ignore -v PATH`. `.gitignore` does **not** untrack files already in Git history; consult your security/repository owner if sensitive data was committed previously. Do not push until reviewed.

When staged contents are safe:

```powershell
git commit -m "docs: add MSK_sample Terraform user guide and GitHub workflow"
```

## 5. Create a new empty PRIVATE GitHub repository

1. Sign in to your organization-approved https://github.com account/organization.
2. Choose **New repository** and name it `oci-terraform-reusable` (or approved name).
3. Choose **Private**.
4. Do **not** select Initialize with README, `.gitignore`, or license—those are already local.
5. Create repository and copy its exact **HTTPS** remote URL.
6. Ensure authorized reviewers have least-privilege repository access.

If the local project already has a `remote`, **do not overwrite it**; investigate first.

```powershell
git remote -v
# Only if 'origin' is not already configured:
git remote add origin https://github.com/APPROVED_ORG/oci-terraform-enterprise.git
git remote -v
```

After verifying the remote and that no sensitive data is tracked, push:

```powershell
git branch --show-current
# If the intended branch is main:
git push -u origin main
```

Authenticate through your approved credential manager / browser (or supported PAT if mandated). Never put a token/password in Git commands, files or screenshots. GitHub generally does not accept Git account passwords for Git operations over HTTPS.

## 6. Everyday change tracking

Get latest updates before editing:

```powershell
git pull --ff-only origin main
```

Create feature branch, make safe source/docs edits:

```powershell
git switch -c docs/add-new-activity-guide
# Edit README, docs, .tfvars.example or Terraform code
git status
git diff
git add README.md docs/
git diff --cached --stat
git commit -m "docs: explain block volume inputs"
git push -u origin docs/add-new-activity-guide
```

Open a **pull request** in GitHub; reviewer checks scopes, IAM/network constraints, module changes and Terraform plan from the right approved environment. Merge only after approval. Avoid auto-running `terraform apply` in GitHub Actions until an approved CI/CD design and secure remote state are in place.

## 7. Rollback / history commands

```powershell
git log --oneline --decorate -10
git diff -- README.md
git show --stat HEAD
git status
```

For mistakes: discuss/review a safe `git revert <commit>` rather than rewriting shared history. `git revert` changes source history; it does **not** undo already-applied OCI infrastructure changes.

## 8. Terraform state is NOT a Git artifact

For teams, use a secure remote backend with access control, locking where supported, separate state keys per project/environment, and a documented migration plan. **Do not move/delete the active local `.tfstate` simply to start tracking code in Git.** Existing working directories and modules may have real or recently managed resources.

Read `docs/PROJECT_INPUTS.md` for every MSK_sample variable, plus each project-specific `README.md` / `terraform.tfvars.example`.
