output "public_ip" {
  description = "Public IP of the VM"
  value       = oci_core_instance.this.public_ip
}

output "web_url" {
  description = "Open WebUI URL"
  value       = "http://${oci_core_instance.this.public_ip}:${var.web_port}"
}

output "ssh_command" {
  description = "SSH command for the VM"
  value       = "ssh ubuntu@${oci_core_instance.this.public_ip}"
}

output "accelerator_repo" {
  description = "Accelerator repository used by cloud-init"
  value       = var.accelerator_repo_url
}
