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
  default     = "openwebui"
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
  default     = 8
}

variable "boot_volume_size_gbs" {
  description = "Boot volume size in GB"
  type        = number
  default     = 80
}

variable "vcn_cidr_block" {
  description = "VCN CIDR block"
  type        = string
  default     = "10.46.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.46.0.0/24"
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed to access SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allow_web_cidr" {
  description = "CIDR allowed to access Open WebUI"
  type        = string
  default     = "0.0.0.0/0"
}

variable "web_port" {
  description = "External Open WebUI port"
  type        = number
  default     = 3000
}

variable "open_webui_version" {
  description = "Open WebUI image tag"
  type        = string
  default     = "v0.8.3"
}

variable "openai_api_base_url" {
  description = "OpenAI-compatible endpoint URL (OCI GenAI endpoint)"
  type        = string
  default     = ""
}

variable "openai_api_key" {
  description = "OpenAI-compatible API key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "default_models" {
  description = "Default model IDs for Open WebUI"
  type        = string
  default     = ""
}

variable "webui_secret_key" {
  description = "Optional fixed secret key for persistent sessions"
  type        = string
  sensitive   = true
  default     = ""
}

variable "enable_oci_accelerator" {
  description = "Clone OCI accelerator fork and keep OCI integration assets"
  type        = bool
  default     = true
}

variable "accelerator_repo_url" {
  description = "OCI accelerator repo URL"
  type        = string
  default     = "https://github.com/oci-ai-architects/oci_open-webui.git"
}

variable "accelerator_ref" {
  description = "Branch or tag to clone from accelerator repo"
  type        = string
  default     = "main"
}

variable "oci_compartment_ocid_override" {
  description = "Optional OCI compartment OCID exposed to runtime"
  type        = string
  default     = ""
}

variable "oci_region_override" {
  description = "Optional OCI region exposed to runtime"
  type        = string
  default     = ""
}

variable "create_iam_resources" {
  description = "Create dynamic group and IAM policy for instance principal"
  type        = bool
  default     = false
}

variable "dynamic_group_name" {
  description = "Dynamic group name when IAM resources are enabled"
  type        = string
  default     = "openwebui-instances"
}

variable "policy_name" {
  description = "Policy name when IAM resources are enabled"
  type        = string
  default     = "openwebui-genai-policy"
}
