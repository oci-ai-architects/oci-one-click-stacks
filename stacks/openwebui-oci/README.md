# openwebui-oci

Deploy upstream Open WebUI on OCI with one click, using OCI OpenAI-compatible
endpoints and optional OCI accelerator assets from
`oci-ai-architects/oci_open-webui`.

## Deploy to OCI

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.2.0/openwebui-oci-stack-v0.2.0.zip)

## Runtime Strategy

- Runtime is pinned to upstream Open WebUI image tag `v0.8.3`.
- OCI accelerator assets can be pulled from
  `https://github.com/oci-ai-architects/oci_open-webui`.
- Optional IAM resources can be created for instance-principal based OCI GenAI
  access patterns.

## Outputs

- `public_ip`
- `web_url`
- `ssh_command`

## Validate and package

```bash
../../scripts/validate-stack.sh stacks/openwebui-oci
../../scripts/package-stack.sh stacks/openwebui-oci /tmp/openwebui-oci.zip
```
