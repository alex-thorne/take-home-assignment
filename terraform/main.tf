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
  target_tags = ["chuck-norris-app"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {
  name         = "chuck-norris-app"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags         = ["allow-ssh", "chuck-norris-app"]
  

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
    ssh-keys = "${var.user}:${file(var.public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo service docker start
    sudo usermod -aG docker ${var.user}
    EOF
}