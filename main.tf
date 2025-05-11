terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }

  backend "gcs" {
    bucket = "rmb-lab-tf_openstack_provider"
  }
}
