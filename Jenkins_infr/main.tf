terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.30.0"
    }
  }
}

provider "google" {
  project = var.project_name
  region = var.region
  zone = var.zone
}

module "jenkins_network" {
  source = "./modules/network"
  env_pref = var.env_pref
  my_ip = var.my_ip
  project_name = var.project_name
  region = var.region
  subnet_cidr = var.subnet_cidr
}

resource "google_compute_instance" "jenkins_server" {
  name = "jenkins-server"
  machine_type = var.instance_type
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = module.jenkins_network.vpc.name
    subnetwork = module.jenkins_network.subnet.name
    access_config {}
  }
  metadata = {
    ssh-keys = "${var.ssh_user_name}:${file(var.public_key_location)}"
  }
  metadata_startup_script = file("entry-script.sh")
}