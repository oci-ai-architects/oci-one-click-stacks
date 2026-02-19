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

## Enterprise Token Demand Lens

Extended list and rationale are now published in:

- `docs/enterprise-token-use.md`
- `catalog/enterprise-token-priority.yaml`

Top additional high-potential stacks for enterprise token growth:

| Candidate | Source | Token Intensity | Why It Drives Token Use |
|---|---|---|---|
| `dify-oci` | `langgenius/dify` | Very high | Multi-step agent workflows turn one task into many model calls. |
| `onyx-oci` | `onyx-dot-app/onyx` | Very high | Org-wide RAG over enterprise data creates high-context, high-concurrency traffic. |
| `ragflow-oci` | `infiniflow/ragflow` | Very high | Deep document understanding pipelines consume long contexts repeatedly. |
| `chatwoot-ai-oci` | `chatwoot/chatwoot` | Very high | Support ticket/chat volumes create sustained production inference demand. |
| `openhands-oci` | `OpenHands/OpenHands` | Very high | Autonomous code loops are token-intensive per task and per iteration. |
| `anything-llm-oci` | `Mintplex-Labs/anything-llm` | High | Team workspace adoption scales concurrent RAG + agent sessions. |

## Live Deploy Buttons

- `hello-oci-vm`:
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.1.0/hello-oci-vm-stack-v0.1.0.zip)
- `uptime-kuma-oci`:
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.2.0/uptime-kuma-oci-stack-v0.2.0.zip)
- `openwebui-oci`:
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.2.0/openwebui-oci-stack-v0.2.0.zip)

### Validate locally

```bash
./scripts/validate-stack.sh stacks/hello-oci-vm
```

### Package ZIP for OCI Resource Manager

```bash
./scripts/package-stack.sh stacks/hello-oci-vm /tmp/hello-oci-vm-stack.zip
```

## OpenWebUI Strategy

- Accelerator fork is now in org:
  `https://github.com/oci-ai-architects/oci_open-webui`
- Runtime follows upstream Open WebUI release tags
  (`open-webui/open-webui`), currently pinned to `v0.8.3`.
- OCI integration assets are preserved via optional accelerator cloning and
  IAM policy bootstrap in `stacks/openwebui-oci`.

## Repo Structure

```text
catalog/
  projects.yaml
scripts/
  package-stack.sh
  validate-stack.sh
stacks/
  hello-oci-vm/
  uptime-kuma-oci/
  openwebui-oci/
ROADMAP.md
```
