variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "region" {
  description = "OCI region"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID for resources"
  type        = string
}

variable "stack_prefix" {
  description = "Prefix for OCI resources"
  type        = string
  default     = "uptimekuma"
}

variable "ssh_public_key" {
  description = "SSH public key for ubuntu user"
  type        = string
}

variable "availability_domain_number" {
  description = "Availability domain index (1-based)"
  type        = number
  default     = 1
}

variable "image_ocid" {
  description = "Optional custom image OCID"
  type        = string
  default     = ""
}

variable "instance_shape" {
  description = "Compute shape"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "instance_ocpus" {
  description = "OCPU count for flex shapes"
  type        = number
  default     = 1
}

variable "instance_memory_in_gbs" {
  description = "Memory in GB for flex shapes"
  type        = number
  default     = 6
}

variable "boot_volume_size_gbs" {
  description = "Boot volume size in GB"
  type        = number
  default     = 50
}

variable "vcn_cidr_block" {
  description = "VCN CIDR block"
  type        = string
  default     = "10.45.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.45.0.0/24"
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed to access SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allow_web_cidr" {
  description = "CIDR allowed to access Uptime Kuma"
  type        = string
  default     = "0.0.0.0/0"
}

variable "web_port" {
  description = "External Uptime Kuma port"
  type        = number
  default     = 3001
}

variable "uptime_kuma_version" {
  description = "Uptime Kuma container tag"
  type        = string
  default     = "1"
}

variable "timezone" {
  description = "Timezone used by VM and container"
  type        = string
  default     = "UTC"
}
