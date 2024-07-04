provider "google" {
  credentials = file("path/to/service-account-file.json")
  project     = "project_id"
  region      = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_firewall" "default" {
  name    = "default-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "77.48.0.0/12",
    "78.102.0.0/15",
    "80.188.0.0/14",
    "81.0.192.0/18",
    "83.208.0.0/13",
  ]
  
}

resource "google_compute_instance" "default" {
  name         = "docker-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20210916"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "user:${file("path_to_ssh_key")}"
  }

  tags = ["ssh"]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i '${google_compute_instance.default.network_interface.0.access_config.0.nat_ip},' ../ansible/playbook.yml
    EOT
  }
}