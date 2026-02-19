# openwebui-oci (Planned)

## Recommendation

Yes, fork `dariomanda/oci_open-webui`, but treat it as a migration source, not final product shape.

Why:
- It already proves OCI GenAI integration and runtime flow.
- It has OpenTofu + Ansible assets we can reuse.
- It is not currently optimized for OCI Deploy-button release packaging.

## Target Deliverable

A clean one-click OCI stack with:
- `schema.yaml`
- Terraform/OpenTofu entrypoint
- Cloud-init-first quick deploy mode
- Optional hardened mode (private subnet + Bastion)
- Release ZIP artifact for `cloud.oracle.com/resourcemanager/stacks/create?zipUrl=...`

## Build Plan

1. Extract the minimal infra footprint from source repo.
2. Remove required local post-steps where possible.
3. Move runtime config to stack variables and cloud-init.
4. Add packaging + validation scripts from this monorepo standard.
