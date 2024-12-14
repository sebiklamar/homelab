resource "proxmox_virtual_environment_vm" "this" {
  for_each = var.nodes

  node_name = each.value.host_node

  # hostname is crafted by environment prefix and domain suffix, e.g. dev-host.example.com
  name            = "${var.env}-${each.key}.${var.network.domain}"
  description     = each.value.node_type == "controlplane" ? "Talos Control Plane" : "Talos Worker"
  tags            = each.value.node_type == "controlplane" ? ["k8s", "control-plane"] : ["k8s", "worker"]
  vm_id           = each.value.vm_id
  on_boot         = true
  started         = true
  stop_on_destroy = true
  tablet_device   = false

  machine         = "q35"
  scsi_hardware   = "virtio-scsi-single"
  bios            = "seabios"
  boot_order      = ["scsi0", "ide3"]
  keyboard_layout = "de"

  agent {
    enabled = true
  }

  cdrom {
    enabled   = true
    file_id   = "ISOs:iso/talos-nocloud-amd64_${var.cluster.talos_version}.iso"
    interface = "ide3"
  }

  cpu {
    cores = each.value.cpu
    type  = "host"
  }

  memory {
    dedicated = each.value.ram_dedicated
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = each.value.mac_address
    vlan_id     = var.network.vlan_id
  }

  disk {
    datastore_id = each.value.datastore_id
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = 10
    # file_id      = proxmox_virtual_environment_download_file.this["${each.value.host_node}_${each.value.update == true ? local.update_image_id : local.image_id}"].id
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 6.X.
  }

  initialization {
    datastore_id = each.value.datastore_id
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.network.gateway
      }
    }
  }

  # wait 3 min instead of standard 1800s/30 min
  timeout_shutdown_vm = 200
  # wait 3 min instead of standard 1800s/30 min
  # timeout_start_vm    = 200
}
