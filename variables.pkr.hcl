variable "orka_user" {
  type    = string
  default = "dtci-cd-pipeline-jenkins@disney.com"
}

variable "orka_password" {
  type      = string
  sensitive = true
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "fastlane_session" {
  type      = string
  sensitive = true
  default   = ""
}

variable "image_name" {
  type      = string
  default   = "automated-packer.img"
}
