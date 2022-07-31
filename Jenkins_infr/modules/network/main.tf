resource "google_compute_network" "vpc" {
  project                 = var.project_name
  name                    =  "${var.project_name}-${var.env_pref}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.env_pref}-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id
  region        = var.region
}

resource "google_compute_router" "igw" {
  name    = "${var.env_pref}-igw"
  network = google_compute_network.vpc.id

}
