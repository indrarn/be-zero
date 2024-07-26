variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "credentials" {
  type = string
}

variable "name_instance" {
  type = string
}

variable "spec" {
  type = string
}

variable "image" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "ssh_private_key" {
  description = "Private key for SSH connection"
  type        = string
}