# OCI One-Click Stacks Roadmap

## Phase 1 (Ship Fast)

1. `hello-oci-vm` (done)
2. `uptime-kuma-oci` (done)
3. `umami-oci`

Exit criteria:
- Every stack has `schema.yaml`, Terraform validate pass, package ZIP artifact.
- README includes deploy button URL bound to release asset.

## Phase 2 (High Utility)

1. `n8n-oci`
2. `openwebui-oci` (done)
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

## Phase 4 (Enterprise Token Growth)

1. `dify-oci`
2. `onyx-oci`
3. `ragflow-oci`
4. `chatwoot-ai-oci`
5. `openhands-oci`

Exit criteria:
- Each stack includes token-governance defaults (model routing, quotas, logs).
- One-click deployment ships with both quick mode and secure mode.
- Workload playbooks clearly map use case to expected token profile.

## OpenWebUI Decision

`dariomanda/oci_open-webui` is a good accelerator, but not yet one-click in OCI Resource Manager form.

Required adaptation:
- Done: created org fork at `oci-ai-architects/oci_open-webui`.
- Done: added RM-first stack packaging in `stacks/openwebui-oci`.
- Done: pinned runtime to upstream Open WebUI release tag (`v0.8.3`).
- Next: add secure mode (private subnet + Bastion) and full gateway path.
