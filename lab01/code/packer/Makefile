.PHONY: version

all: help


init: ## Install missing plugins for packer
	@mkdir -p ""`pwd`"/.config/packer/plugins"
	@export PACKER_CONFIG_DIR=""`pwd`"/.config/packer"; export PACKER_PLUGIN_PATH=""`pwd`"/.config/packer/plugins"; packer init vagrant-rocky.pkr.hcl

virtualbox:	init    ## Build Rocky Linux box for Virtualbox
	-@VBoxManage setproperty language C
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export TMPDIR=""`pwd`""; export PACKER_CONFIG_DIR=""`pwd`"/.config/packer"; export PACKER_PLUGIN_PATH=""`pwd`"/.config/packer/plugins"; packer build -only=virtualbox-iso.rockylinux vagrant-rocky.pkr.hcl
	@VBoxManage setproperty machinefolder default

qemu:	init    ## Build Rocky Linux box for Qemu
	@export TMPDIR=""`pwd`""; export PACKER_CONFIG_DIR=""`pwd`"/.config/packer"; export PACKER_PLUGIN_PATH=""`pwd`"/.config/packer/plugins"; packer build -only=qemu.rockylinux vagrant-rocky.pkr.hcl

help:
	@echo 'Usage:'
	@echo '  make <target>'
	@echo
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_0-9.-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
