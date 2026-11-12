# Activity status — validation from the original test environment

**Evidence source:** User-shared Terraform CLI outputs and OCI Console screenshots from November 2026. Final GitHub remote setup has **not yet been completed**.

| Area | Activity | Status / limitations |
|---|---|---|
| Storage | 100 GB Block Volume create, attach, FULL backup, restore | Created and cleaned up successfully in shared tests; original volume, backup, restored volume and attachment deleted |
| Storage | FSS File System, Mount Target and Export | Created, plan showed no drift, `terraform destroy` reported 3 destroyed; no Linux client mount test |
| Storage | Private Object Storage bucket + sample file | Created, 128-byte test object uploaded and deleted, bucket deleted; `prevent_destroy` restored (user confirmed) |
| Compute | Single-server and boot-volume workflows | Historical test work; review each workflow/state and SOP for exact validation; do not infer every case passed |
| Compute | Multi-server `for_each` / `count` | Previously tested, but review final state and deletion protection before reuse |
| Compute | Custom-image workflow | **ON HOLD** |
| GitHub | Private repository and first push | **NOT YET DONE** — follow `GITHUB_SETUP.md` |

**Unverified on latest session:** final empty-state verification after Object Storage test, final protection settings in every older project, whether server used for block attachment was subsequently stopped, current git repository status and remote URL. Check these rather than guessing.
