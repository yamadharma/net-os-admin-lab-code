packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "artifact_description" {
  type    = string
  default = "Rocky 10.0"
}

variable "artifact_version" {
  type    = string
  default = "10.0"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "iso_checksum" {
  type    = string
  default = "de75c2f7cc566ea964017a1e94883913f066c4ebeb1d356964e398ed76cadd12"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_url" {
  type    = string
  # default = "https://download.rockylinux.org/pub/rocky/10/isos/x86_64/Rocky-10.0-x86_64-minimal.iso"
  default = "Rocky-10.0-x86_64-minimal.iso"
}

variable "redhat_platform" {
  type    = string
  default = "x86_64"
}

variable "redhat_release" {
  type    = string
  default = "10"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "http_directory" {
  type    = string
  default = "http"
}

source "qemu" "rockylinux" {
  boot_command           = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky10-ks.cfg ",
    " biosdevname=0 net.ifnames=0 ",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait               = "10s"
  disk_size               = "${var.disk_size}"
  http_directory          = "${path.root}/${var.http_directory}"
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  output_directory        = "output-rockylinux${var.redhat_release}-qemu"
  format                  = "qcow2"
  ssh_password            = "${var.ssh_password}"
  ssh_username            = "${var.ssh_username}"
  ssh_timeout             = "60m"
  vm_name                 = "rockylinux${var.redhat_release}-qemu"
  net_device              = "virtio-net"
  disk_interface          = "virtio"
  # headless                = true

  # Настройки QEMU
  # Параметры процессора
  cpus                   = 2
  memory                 = 2048
  accelerator            = "kvm"
  cpu_model              = "host"           # Использовать характеристики хоста
  machine_type           = "q35"            # Тип системной платы
  firmware               = "/usr/share/edk2-ovmf/OVMF_CODE.fd" # UEFI вместо BIOS. Проверьте местоположение

  # Настройки видео
  vga              = "virtio" # Для virtio-vga

  ## Дополнительные флаги процессора
  qemuargs = [
    ["-device", "qemu-xhci"], # Виртуализированные USB-контроллеры
    ["-device", "virtio-tablet"], # Устройства ввода
    ## GPU-passthrough
    # ["-device", "virtio-gpu-pci"], #  3D-акселерация через VirGL
    # ["-vga", "none"]
  ]
}

source "virtualbox-iso" "rockylinux" {
  boot_command = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky10-ks.cfg ",
    " biosdevname=0 net.ifnames=0 ",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait               = "10s"
  disk_size               = "${var.disk_size}"
  export_opts             = [
    "--manifest",
    "--vsys", "0",
    "--description", "${var.artifact_description}",
    "--version", "${var.artifact_version}"
  ]
  guest_additions_path    = "VBoxGuestAdditions.iso"
  guest_os_type           = "RedHat_64"
  http_directory          = "${var.http_directory}"
  iso_checksum            = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  output_directory        = "output-rockylinux${var.redhat_release}-virtualbox"
  shutdown_command        = "sudo -S /sbin/halt -h -p"
  shutdown_timeout        = "5m"
  ssh_password            = "${var.ssh_password}"
  ssh_username            = "${var.ssh_username}"
  ssh_port                = 22
  ssh_pty                 = true
  ssh_timeout             = "60m"
  iso_interface           = "sata"
  headless                = true
  vboxmanage              = [
    [ "modifyvm", "{{.Name}}", "--memory", "2048" ],
    [ "modifyvm", "{{.Name}}", "--cpus", "2" ],
    [ "modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on" ],
    [ "modifyvm", "{{.Name}}", "--firmware", "EFI" ],
    ["modifyvm", "{{.Name}}", "--vrde", "on"],
    ["modifyvm", "{{.Name}}", "--vrdeport", "3390"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "rockylinux${var.redhat_release}-virtualbox"
}

build {
  sources = [
    "source.virtualbox-iso.rockylinux",
    "source.qemu.rockylinux"
  ]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["scripts/vagrant.sh", "scripts/software.sh"]
  }

  provisioner "shell" {
    only           = ["virtualbox-iso.rockylinux"]
    script         = "scripts/virtualbox.sh"
  }

  provisioner "shell" {
    script         = "scripts/cleanup.sh"
  }

  post-processor "vagrant" {
    compression_level = "6"
    output            = "vagrant-{{ .Provider }}-rockylinux${var.redhat_release}-${var.redhat_platform}.box"
  }
}
