locals {
  ubuntu_noble_lts_amd64_images = {
    "20250516" : {
      url  = "https://mirrors.rit.edu/ubuntu-cloud/cloud-images/noble/20250516/noble-server-cloudimg-amd64.img"
      tags = ["latest"]
    }
    "20250502.1" : {
      url  = "https://mirrors.rit.edu/ubuntu-cloud/cloud-images/noble/20250502.1/noble-server-cloudimg-amd64.img"
      tags = []
    }
    "20250430" : {
      url  = "https://mirrors.rit.edu/ubuntu-cloud/cloud-images/noble/20250430/noble-server-cloudimg-amd64.img"
      tags = []
    }
  }
}

resource "terraform_data" "noble-server-cloudimg-amd64" {
  for_each = local.ubuntu_noble_lts_amd64_images

  # This will always trigger a replace and make plans ugly
  # No nice way around this right now though
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = "curl -o /tmp/noble-server-cloudimg-amd64-${each.key}.img ${each.value.url}"
  }

  provisioner "local-exec" {
    command = "qemu-img convert /tmp/noble-server-cloudimg-amd64-${each.key}.img /tmp/noble-server-cloudimg-amd64-${each.key}.raw"
  }
}

resource "openstack_images_image_v2" "noble-server-cloudimg-amd64" {
  for_each = local.ubuntu_noble_lts_amd64_images

  depends_on = [terraform_data.noble-server-cloudimg-amd64]

  name = "Ubuntu Noble LTS Server Cloud AMD64 - ${each.key}"

  local_file_path = "/tmp/noble-server-cloudimg-amd64-${each.key}.raw"

  container_format = "bare"
  disk_format      = "raw"

  visibility = "public"

  properties = {
    hw_firmware_type = "uefi"
    os_secure_boot   = "required"
    hw_machine_type  = "q35"

    os_type    = "linux"
    os_distro  = "ubuntu"
    os_version = "24.04"

    hw_vif_model              = "virtio"
    hw_vif_multiqueue_enabled = "true"
  }

  tags = concat([
    "ubuntu-noble-lts-amd64"
  ], each.value.tags)
}
