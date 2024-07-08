provider "google" {
  credentials = var.sa_account_credentials
  project = var.project_id
  region  = var.region
  zone    = var.zone
  
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["docker-instance"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {
  name         = "docker-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["allow-ssh", "docker-instance"]
  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "ansible_user:${file(var.public_key_path)}"
  }
}