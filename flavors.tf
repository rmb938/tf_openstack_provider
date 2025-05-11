resource "openstack_compute_flavor_v2" "c1-standard-1" {
  name  = "my-flavor"
  vcpus = 1
  ram   = 2 * 1024
  disk  = 30

  is_public = true
}

resource "openstack_compute_flavor_v2" "c1-standard-2" {
  name  = "my-flavor"
  vcpus = 2
  ram   = 4 * 1024
  disk  = 30

  is_public = true
}

resource "openstack_compute_flavor_v2" "c1-standard-4" {
  name  = "my-flavor"
  vcpus = 4
  ram   = 8 * 1024
  disk  = 30

  is_public = true
}

resource "openstack_compute_flavor_v2" "c1-standard-8" {
  name  = "my-flavor"
  vcpus = 8
  ram   = 16 * 1024
  disk  = 30

  is_public = true
}
