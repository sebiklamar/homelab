variable "proxmox" {
  type = object({
    endpoint     = string
    insecure     = bool
    username     = string
    api_token    = string
  })
  sensitive = true
}

variable "cluster" {
  description = "talos k8s cluster configuration"
  type = object({
    name          = optional(string, "talos")
    talos_version = string
  })
}

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = map(object({
    host_node     = optional(string, "pve2")
    node_type     = string
    datastore_id  = optional(string, "local-enc")
    ip            = string
    mac_address   = string
    vm_id         = number
    cpu           = number
    ram_dedicated = number
    update        = optional(bool, false)
  }))
}

variable "network" {
  description = "node network configuration"
  type = object({
    gateway = string
    vlan_id = optional(number, 0)
    domain  = string
  })
}

variable "env" {
  description = "environment-specific prefix for e.g. hostnames (e.g. dev-, qa-)"
  type        = string
}
