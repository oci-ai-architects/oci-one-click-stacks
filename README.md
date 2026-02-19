# OCI One-Click Stacks

A curated portfolio of `Deploy to Oracle Cloud` stacks built for fast time-to-value.

Goal: start with ultra-simple stacks that deploy in minutes, then grow into higher-value AI/app platforms (including OpenClaw/OpenWebUI class deployments).

## What You Get

- OCI Resource Manager-compatible Terraform/OpenTofu stacks.
- Deploy-button-ready ZIP packaging.
- Validation scripts so every stack is shippable.
- A complexity ladder to prioritize what to build next.

## Complexity Ladder (Simple -> Advanced)

| Stage | Stack | Why It Matters | Effort |
|---|---|---|---|
| 0 | `hello-oci-vm` | Immediate success signal in tenant (public page + SSH) | Very low |
| 1 | `uptime-kuma-oci` | Useful monitoring from day one | Low |
| 2 | `umami-oci` | Privacy analytics starter for websites | Low |
| 3 | `n8n-oci` | Automation + AI workflows, broad market pull | Medium |
| 4 | `openwebui-oci` | Strong AI UX demand; gateway to OCI GenAI | Medium |
| 5 | `flowise-oci` | Visual agent workflows for teams | Medium |
| 6 | `langfuse-oci` | LLM observability/evals for production teams | Medium-high |
| 7 | `openclaw-oci` | Advanced agent runtime + OCI GenAI + Vault patterns | High |

Full prioritization is in `catalog/projects.yaml` and `ROADMAP.md`.

## Starter Stack

First working stack is `stacks/hello-oci-vm`.

### Deploy to OCI

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.1.0/hello-oci-vm-stack-v0.1.0.zip)

### Validate locally

```bash
./scripts/validate-stack.sh stacks/hello-oci-vm
```

### Package ZIP for OCI Resource Manager

```bash
./scripts/package-stack.sh stacks/hello-oci-vm /tmp/hello-oci-vm-stack.zip
```

## OpenWebUI Track

Decision and build plan: `stacks/openwebui-oci/README.md`.

Short version: forking `dariomanda/oci_open-webui` is viable, but we should refactor to a Resource-Manager-first structure (single stack entrypoint, schema, packaging, and OCI-button release assets).

## Repo Structure

```text
catalog/
  projects.yaml
scripts/
  package-stack.sh
  validate-stack.sh
stacks/
  hello-oci-vm/
  openwebui-oci/
ROADMAP.md
```
