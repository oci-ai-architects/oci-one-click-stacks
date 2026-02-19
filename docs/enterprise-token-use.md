# Enterprise GenAI Token Demand Portfolio

This portfolio ranks OSS one-click stack candidates by expected **enterprise GenAI token consumption**.

Scoring logic:
- **User concurrency**: how many employees/end-users can hit the system at once.
- **Calls per task**: single-turn chat vs multi-step/agentic chains.
- **Context size**: short prompts vs long document/code context windows.
- **Background usage**: scheduled automations, eval loops, replay jobs.

## Highest Token Demand Candidates

| Rank | Stack Candidate | OSS Source | Token Intensity | Enterprise Use Cases | Why Token Use Is High |
|---|---|---|---|---|---|
| 1 | `dify-oci` | `langgenius/dify` | Very high | AI workflow platform for support, ops, legal, HR, sales | Multi-step workflows trigger multiple model calls per request, often at high volume with tool retries. |
| 2 | `n8n-oci` | `n8n-io/n8n` | Very high | Event-driven automations, agent workflows, process orchestration | Scheduled and event-based workflows generate continuous background token traffic, not just interactive chat. |
| 3 | `openwebui-oci` | `open-webui/open-webui` | High | Organization-wide AI chat front door | Broad user adoption across teams creates sustained daily conversational load. |
| 4 | `onyx-oci` | `onyx-dot-app/onyx` | Very high | Enterprise knowledge assistant over internal docs/systems | High concurrency plus long-context RAG interactions on internal corpora. |
| 5 | `ragflow-oci` | `infiniflow/ragflow` | Very high | Deep document QA, policy/compliance copilots | Long document ingestion and retrieval-augmented answering burns large context windows. |
| 6 | `anything-llm-oci` | `Mintplex-Labs/anything-llm` | High | Team knowledge workspaces and agentic assistants | Cross-team workspaces and frequent multi-source retrieval drive repeated token-heavy sessions. |
| 7 | `openhands-oci` | `OpenHands/OpenHands` | Very high | Engineering code agents and autonomous implementation loops | Iterative plan/code/test/fix loops produce many long-context generations per ticket. |
| 8 | `langgraph-platform-oci` | `langchain-ai/langgraph` | High | Stateful multi-agent business process execution | Graph orchestration expands one user request into many model steps and retries. |
| 9 | `chatwoot-ai-oci` | `chatwoot/chatwoot` | Very high | Customer support agent-assist and auto-reply | High ticket/chat throughput turns into sustained production token demand. |
| 10 | `letta-oci` | `letta-ai/letta` | High | Persistent memory agents for operations and account workflows | Memory refresh/summarization and long-running agent threads add background inference load. |
| 11 | `langfuse-oci` | `langfuse/langfuse` | Medium-high | Eval, prompt testing, quality governance | Eval datasets and regression testing intentionally multiply model calls. |
| 12 | `litellm-gateway-oci` | `BerriAI/litellm` | Medium (multiplier) | Central AI gateway, routing, governance, quota controls | Gateway itself does not create demand, but it removes adoption friction and expands token use enterprise-wide. |

## Why These Drive Enterprise Token Growth

1. They move from single-user demos to **org-wide daily workflows**.
2. They convert one action into **multi-call chains** (agent/tool patterns).
3. They operate in **batch or event mode**, creating always-on consumption.
4. They use **long context** (docs, tickets, codebases), increasing tokens per call.

## Recommended Build Order (Token Growth Focus)

1. `dify-oci`
2. `n8n-oci`
3. `onyx-oci`
4. `ragflow-oci`
5. `chatwoot-ai-oci`
6. `openhands-oci`

## OCI Packaging Standard

For each stack candidate, ship:
- `schema.yaml` for OCI Resource Manager UI variables.
- Terraform stack with validated defaults.
- Release ZIP artifact for deploy button.
- `quick` (public) and `secure` (private + Bastion) modes.

Detailed ranked BoM is published in:
- `docs/enterprise-token-bom.md`
- `catalog/enterprise-token-bom.yaml`
