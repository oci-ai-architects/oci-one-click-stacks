output "public_ip" {
  description = "Public IP of hello VM"
  value       = oci_core_instance.this.public_ip
}

output "web_url" {
  description = "Nginx landing page URL"
  value       = "http://${oci_core_instance.this.public_ip}"
}

output "ssh_command" {
  description = "SSH command"
  value       = "ssh ubuntu@${oci_core_instance.this.public_ip}"
}
