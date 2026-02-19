# hello-oci-vm

Deploys a minimal Ubuntu VM on OCI with Nginx preinstalled and a default landing page.

## Outputs

- `public_ip`
- `web_url`
- `ssh_command`

## Validate and package

```bash
../../scripts/validate-stack.sh stacks/hello-oci-vm
../../scripts/package-stack.sh stacks/hello-oci-vm /tmp/hello-oci-vm-stack.zip
```
