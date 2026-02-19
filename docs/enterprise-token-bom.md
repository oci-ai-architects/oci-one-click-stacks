# Enterprise GenAI Stack Ranking and BoM

This is a deployment-first ranking of OSS one-click stacks based on expected
enterprise GenAI token consumption.

## Ranking Method

Combined score:
- **Token growth potential (60%)**
- **Enterprise adoption breadth (25%)**
- **One-click deploy feasibility (15%)**

## Ranked Portfolio (Current)

| Rank | Stack | Token Potential (1-10) | Deploy Effort (1-10) | One-Click Pattern |
|---|---|---:|---:|---|
| 1 | `dify-oci` | 10 | 6 | VM + Docker Compose |
| 2 | `n8n-oci` | 10 | 5 | VM + Docker Compose |
| 3 | `onyx-oci` | 9 | 7 | VM + Docker Compose |
| 4 | `ragflow-oci` | 9 | 7 | VM + Docker Compose |
| 5 | `chatwoot-ai-oci` | 9 | 7 | VM + Docker Compose |
| 6 | `openwebui-oci` | 8 | 4 | Single VM |
| 7 | `openhands-oci` | 9 | 8 | VM + Docker Compose |
| 8 | `anything-llm-oci` | 8 | 5 | Single VM |
| 9 | `langgraph-platform-oci` | 8 | 8 | VM + Services |
| 10 | `letta-oci` | 8 | 8 | VM + Services |
| 11 | `langfuse-oci` | 7 | 7 | VM + Services |
| 12 | `litellm-gateway-oci` | 6 | 5 | Gateway VM |

## BoM by Stack

### 1) `dify-oci`

Minimal BoM:
- OCI: VCN, public subnet, internet gateway, security list, compute VM,
  block volume, boot diagnostics.
- OSS: `dify`, `postgres`, `redis`, optional `weaviate` or external vector DB.

Enterprise BoM:
- OCI: private subnet, bastion, load balancer, Vault, Logging, Monitoring,
  optional WAF.
- OSS: same as minimal + worker scaling and queue tuning.

Token multipliers:
- Workflow fan-out, tool retries, scheduled agents, long-context prompts.

### 2) `n8n-oci`

Minimal BoM:
- OCI: VCN, public subnet, VM, block volume.
- OSS: `n8n`, `postgres`.

Enterprise BoM:
- OCI: private subnet, bastion, load balancer, Vault, Object Storage backups,
  Logging/Monitoring.
- OSS: queue mode workers, Redis (optional), webhook and cron segregation.

Token multipliers:
- Triggered automations, background jobs, multi-step chains.

### 3) `onyx-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `onyx`, `postgres`, `redis`, connector services.

Enterprise BoM:
- OCI: private network + bastion, LB, Vault, Object Storage for connector state,
  Logging/Monitoring.
- OSS: ingestion workers, reindex jobs, permission-aware connectors.

Token multipliers:
- Enterprise RAG over many connectors and high user concurrency.

### 4) `ragflow-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `ragflow`, `mysql/postgres` (depending on runtime profile), vector
  backend, parser services.

Enterprise BoM:
- OCI: private network, bastion, LB, Vault, Object Storage for document staging,
  Logging/Monitoring.
- OSS: ingestion pipeline workers, OCR/document parsing scale-out.

Token multipliers:
- Long document ingestion and retrieval-augmented answering.

### 5) `chatwoot-ai-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `chatwoot`, `postgres`, `redis`, optional sidecar AI worker.

Enterprise BoM:
- OCI: private subnet, LB, Vault, Object Storage for attachments,
  Logging/Monitoring.
- OSS: worker autoscaling, queue isolation, channel connectors.

Token multipliers:
- High support ticket volume, summarization, reply generation.

### 6) `openwebui-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `open-webui`.

Enterprise BoM:
- OCI: private mode, bastion, LB, Vault, IAM policy for OCI GenAI,
  Logging/Monitoring.
- OSS: optional accelerator assets from `oci_open-webui` fork.

Token multipliers:
- Org-wide daily chat usage and long enterprise prompts.

### 7) `openhands-oci`

Minimal BoM:
- OCI: VCN, VM with higher CPU/RAM, block volume.
- OSS: `OpenHands`, task runtime containers.

Enterprise BoM:
- OCI: private subnet, bastion, Vault, Logging/Monitoring, optional dedicated
  artifact storage.
- OSS: isolated execution sandboxes and job queue controls.

Token multipliers:
- Iterative code generation loops with long context and retries.

### 8) `anything-llm-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `anything-llm`, optional vector backend.

Enterprise BoM:
- OCI: private mode, bastion, LB, Vault, Object Storage for document assets,
  Logging/Monitoring.
- OSS: team workspace segmentation and ingestion jobs.

Token multipliers:
- Cross-team workspace usage and repeated RAG calls.

### 9) `langgraph-platform-oci`

Minimal BoM:
- OCI: VCN, VM(s), block volumes.
- OSS: LangGraph runtime, API layer, state store.

Enterprise BoM:
- OCI: private subnets, LB, Vault, Monitoring/Logging, queue and state store
  services.
- OSS: orchestrator workers, state persistence, HITL review components.

Token multipliers:
- Graph-based multi-agent execution and branch retries.

### 10) `letta-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `letta`, memory/state backend.

Enterprise BoM:
- OCI: private mode, bastion, Vault, Logging/Monitoring.
- OSS: memory compaction, retrieval services, long-running agents.

Token multipliers:
- Persistent memory refresh and continuous agent interaction.

### 11) `langfuse-oci`

Minimal BoM:
- OCI: VCN, VM, block volume.
- OSS: `langfuse`, `postgres`, `clickhouse` profile as needed.

Enterprise BoM:
- OCI: private mode, Vault, Logging/Monitoring, Object Storage exports.
- OSS: eval runners and regression suites.

Token multipliers:
- Eval and QA pipelines repeatedly call models.

### 12) `litellm-gateway-oci`

Minimal BoM:
- OCI: VCN, VM.
- OSS: `litellm` proxy.

Enterprise BoM:
- OCI: private mode, LB, Vault, Logging/Monitoring.
- OSS: policy routing, budget controls, fallback policies.

Token multipliers:
- Indirect: gateway standardization increases org adoption and total calls.

## Additional Watchlist (Next)

- `LibreChatAI/LibreChat` (`librechat-oci`)
- `lobehub/lobe-chat` (`lobechat-oci`)
- `deepset-ai/haystack` (`haystack-platform-oci`)
- `vllm-project/vllm` (`vllm-serving-oci`, private model serving profile)

These are strong secondary candidates but were ranked below current top 12 for
near-term one-click portfolio impact.
