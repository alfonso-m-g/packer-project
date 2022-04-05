packer {
  required_plugins {
    macstadium-orka = {
      version = ">= 2.4.0"
      source  = "github.com/macstadium/macstadium-orka"
    }
  }
}

source "macstadium-orka" "image" {
  source_image                = "250GBigSurSSH.img"
  image_name                  = var.image_name
  orka_endpoint               = "http://207.254.35.166"
  orka_user                   = var.orka_user
  orka_password               = var.orka_password
  ssh_password                = var.ssh_password
  enable_orka_node_ip_mapping = true
  orka_node_ip_map = {
    "172.23.188.114" = "207.254.35.164"
    "172.23.188.115" = "207.254.35.165"
    "172.23.188.116" = "207.254.35.167"
    "172.23.188.117" = "207.254.35.168"
    "172.23.188.118" = "207.254.35.169"
    "172.23.188.119" = "207.254.35.170"
    "172.23.188.120" = "207.254.35.171"
    "172.23.188.125" = "207.254.35.176"
    "172.23.188.126" = "207.254.54.211"
    "172.23.188.127" = "207.254.54.212"
  }
}

build {
  sources = ["macstadium-orka.image"]

  provisioner "shell" {
    inline = ["mkdir -p /Users/admin/ansible"]
  }

  provisioner "file" {
    destination = "/Users/admin"
    source      = "ansible"
  }

  provisioner "file" {
    destination = "/tmp/password.txt"
    source      = "password.txt"
    generated   = true
  }

  provisioner "shell" {
    environment_vars = ["SUDO_PW=${var.ssh_password}",
                        "FASTLANE_SESSION=${var.fastlane_session}"]
    remote_path      = "/Users/admin/provision.sh"
    script           = "provision.sh"
  }
}
