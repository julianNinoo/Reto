provider "google" {
  project = "prueba-020421"
  credentials = file("prueba-020421-92334dc99723.json")
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "addi3"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 #    A default network is created for all GCP projects
   network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform"
  auto_create_subnetworks = "true"
}
