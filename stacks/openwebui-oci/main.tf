data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "ubuntu_22" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"
  shape                    = var.instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

locals {
  stack_name                = var.stack_prefix
  vcn_name                  = "${var.stack_prefix}-vcn"
  subnet_name               = "${var.stack_prefix}-public"
  instance_name             = "${var.stack_prefix}-vm"
  availability_domain       = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain_number - 1].name
  selected_image_ocid       = var.image_ocid != "" ? var.image_ocid : data.oci_core_images.ubuntu_22.images[0].id
  effective_oci_compartment = var.oci_compartment_ocid_override != "" ? var.oci_compartment_ocid_override : var.compartment_ocid
  effective_oci_region      = var.oci_region_override != "" ? var.oci_region_override : var.region
  policy_statements         = ["Allow dynamic-group ${var.dynamic_group_name} to use generative-ai-family in compartment id ${var.compartment_ocid}"]
}

resource "oci_core_vcn" "this" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = [var.vcn_cidr_block]
  display_name   = local.vcn_name
  dns_label      = "owuvcn"
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.stack_prefix}-igw"
  enabled        = true
}

resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.stack_prefix}-public-sl"

  ingress_security_rules {
    protocol = "6"
    source   = var.allow_ssh_cidr

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.allow_web_cidr

    tcp_options {
      min = var.web_port
      max = var.web_port
    }
  }

  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.stack_prefix}-public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

resource "oci_core_subnet" "public" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.this.id
  cidr_block                 = var.public_subnet_cidr_block
  display_name               = local.subnet_name
  dns_label                  = "pub"
  route_table_id             = oci_core_route_table.public.id
  security_list_ids          = [oci_core_security_list.public.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_instance" "this" {
  availability_domain = local.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = local.instance_name
  shape               = var.instance_shape

  dynamic "shape_config" {
    for_each = length(regexall("Flex", var.instance_shape)) > 0 ? [1] : []
    content {
      ocpus         = var.instance_ocpus
      memory_in_gbs = var.instance_memory_in_gbs
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    display_name     = "${local.instance_name}-vnic"
    hostname_label   = "owui"
  }

  source_details {
    source_type             = "image"
    source_id               = local.selected_image_ocid
    boot_volume_size_in_gbs = var.boot_volume_size_gbs
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(templatefile("${path.module}/cloud-init.tftpl", {
      stack_name               = local.stack_name
      web_port                 = var.web_port
      open_webui_version       = var.open_webui_version
      openai_api_base_url_b64  = base64encode(var.openai_api_base_url)
      openai_api_key_b64       = base64encode(var.openai_api_key)
      default_models_b64       = base64encode(var.default_models)
      webui_secret_key_b64     = base64encode(var.webui_secret_key)
      enable_oci_accelerator   = tostring(var.enable_oci_accelerator)
      accelerator_repo_url     = var.accelerator_repo_url
      accelerator_ref          = var.accelerator_ref
      oci_compartment_ocid_b64 = base64encode(local.effective_oci_compartment)
      oci_region_b64           = base64encode(local.effective_oci_region)
    }))
  }
}

resource "oci_identity_dynamic_group" "openwebui_instances" {
  count = var.create_iam_resources ? 1 : 0

  compartment_id = var.tenancy_ocid
  name           = var.dynamic_group_name
  description    = "Dynamic group for Open WebUI compute instances"
  matching_rule  = "ALL {instance.compartment.id = '${var.compartment_ocid}'}"
}

resource "oci_identity_policy" "openwebui" {
  count = var.create_iam_resources ? 1 : 0

  compartment_id = var.tenancy_ocid
  name           = var.policy_name
  description    = "Policy for Open WebUI OCI GenAI access"
  statements     = local.policy_statements

  depends_on = [oci_identity_dynamic_group.openwebui_instances]
}
