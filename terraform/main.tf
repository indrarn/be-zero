terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.84.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials)
}

resource "google_compute_instance" "default" {
  name         = var.name_instance
  machine_type = var.spec

  tags = var.network_tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {}
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo docker swarm init --advertise-addr $(hostname -I | awk '{print $1}')"
    ]

    connection {
      type        = "ssh"
      user        = "indrarn"
      private_key = file("~/.ssh/id_rsa")
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }
}

output "public_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

provider "docker" {
  host = "tcp://${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}:2376"
}

resource "docker_service" "be_zero" {
  name     = "be-zero"
  image    = "indrarn/be-zero:${var.image_tag}"
  replicas = 1

  task_spec {
    container_spec {
      image = "indrarn/be-zero:${var.image_tag}"
    }
  }
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
}
