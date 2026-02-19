# uptime-kuma-oci

Deploy Uptime Kuma on an OCI VM with Docker in a single stack apply.

## Deploy to OCI

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oci-ai-architects/oci-one-click-stacks/releases/download/v0.2.0/uptime-kuma-oci-stack-v0.2.0.zip)

## Outputs

- `public_ip`
- `web_url`
- `ssh_command`

## Validate and package

```bash
../../scripts/validate-stack.sh stacks/uptime-kuma-oci
../../scripts/package-stack.sh stacks/uptime-kuma-oci /tmp/uptime-kuma-oci.zip
```
