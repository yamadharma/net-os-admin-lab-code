packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

variable "artifact_description" {
  type    = string
  default = "Rocky 9.2"
}

variable "artifact_version" {
  type    = string
  default = "9.2"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "06505828e8d5d052b477af5ce62e50b938021f5c28142a327d4d5c075f0670dc"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_url" {
  type    = string
  default = "Rocky-9.2-x86_64-minimal.iso"
}

variable "redhat_platform" {
  type    = string
  default = "x86_64"
}

variable "redhat_release" {
  type    = string
  default = "9"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

source "virtualbox-iso" "virtualbox" {
  boot_command            = [
    "<esc>",
    "<wait><esc><esc>",
    "linux inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks.cfg biosdevname=0 net.ifnames=0",
    "<enter>"
  ]
  boot_wait               = "30s"
  disk_size               = "${var.disk_size}"
  export_opts             = [
    "--manifest",
    "--vsys", "0",
    "--description", "${var.artifact_description}",
    "--version", "${var.artifact_version}"
  ]
  guest_additions_path    = "VBoxGuestAdditions.iso"
  guest_os_type           = "RedHat_64"
  hard_drive_interface    = "sata"
  http_directory          = "${path.root}/http"
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  output_directory        = "builds"
  shutdown_command        = "sudo -S /sbin/halt -h -p"
  shutdown_timeout        = "5m"
  ssh_password            = "${var.ssh_password}"
  ssh_username            = "${var.ssh_username}"
  ssh_port                = 22
  ssh_pty                 = true
  ssh_timeout             = "60m"
  vboxmanage              = [
    ["modifyvm", "{{.Name}}", "--memory", "2048"],
    ["modifyvm", "{{.Name}}", "--cpus", "2"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ] 
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-rocky-virtualbox-vm"
}

build {
  sources = ["source.virtualbox-iso.virtualbox"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = [
      "sleep 30",
      "sudo dnf -y install epel-release",
      "sudo dnf -y groupinstall 'Development Tools'",
      "sudo dnf -y install kernel-devel",
      "sudo dnf -y install dkms",
      "sudo mkdir /tmp/vboxguest",
      "sudo mount -t iso9660 -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/vboxguest",
      "cd /tmp/vboxguest",
      "sudo ./VBoxLinuxAdditions.run",
      "cd /tmp",
      "sudo umount /tmp/vboxguest",
      "sudo rmdir /tmp/vboxguest",
      "rm /home/vagrant/VBoxGuestAdditions.iso",
      "sudo systemctl enable --now vboxadd.service",
      "sudo dnf -y install lightdm",
      "sudo dnf -y groupinstall 'Server with GUI'",
      "sudo dnf install -y mc htop tmux",
      "sudo systemctl set-default graphical.target",
      "echo Image Provisioned!"
    ]
  }

  post-processor "vagrant" {
    compression_level = "6"
    output            = "vagrant-virtualbox-rocky-${var.redhat_release}-${var.redhat_platform}.box"
  }
}

