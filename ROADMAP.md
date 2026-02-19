# OCI One-Click Stacks Roadmap

## Phase 1 (Ship Fast)

1. `hello-oci-vm` (done)
2. `uptime-kuma-oci`
3. `umami-oci`

Exit criteria:
- Every stack has `schema.yaml`, Terraform validate pass, package ZIP artifact.
- README includes deploy button URL bound to release asset.

## Phase 2 (High Utility)

1. `n8n-oci`
2. `openwebui-oci`
3. `flowise-oci`

Exit criteria:
- Secrets moved to OCI Vault where feasible.
- IAM least-privilege defaults provided.
- Cloud-init path and container runtime path both documented.

## Phase 3 (Advanced AI Ops)

1. `langfuse-oci`
2. `openclaw-oci`
3. `clawhub-oci` (optional dedicated assistant + skills bundle)

Exit criteria:
- Enterprise profile: private subnet + Bastion option.
- Observability baseline: logging/monitoring hooks.
- Upgrade/migration docs between stack versions.

## OpenWebUI Decision

`dariomanda/oci_open-webui` is a good accelerator, but not yet one-click in OCI Resource Manager form.

Required adaptation:
- Move from multi-step local OpenTofu+Ansible flow to RM stack ZIP flow.
- Add OCI `schema.yaml` and release packaging script.
- Offer two modes:
  - quick mode: public VM + OpenWebUI
  - secure mode: private VM + Bastion + tighter security lists
