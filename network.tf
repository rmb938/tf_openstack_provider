resource "openstack_networking_network_v2" "provider" {
  name           = "provider"
  admin_state_up = "true"

  shared   = true
  external = true

  segments {
    physical_network = "provider"
    network_type     = "flat"
  }
}

resource "openstack_networking_subnet_v2" "provider" {
  name            = "provider"
  network_id      = openstack_networking_network_v2.provider.id
  cidr            = "192.168.52.0/24"
  dns_nameservers = ["192.168.23.254"]
  gateway_ip      = "192.168.52.254"
  ip_version      = 4

  allocation_pool {
    start = "192.168.52.50"
    end   = "192.168.52.150"
  }
}
