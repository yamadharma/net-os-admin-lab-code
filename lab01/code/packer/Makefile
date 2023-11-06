.PHONY: version

all: init box

init: ## Install missing plugins for packer
	@mkdir -p ""`pwd`"/.config/packer/plugins"
	@export PACKER_CONFIG_DIR=""`pwd`"/.config/packer"; export PACKER_PLUGIN_PATH=""`pwd`"/.config/packer/plugins"; packer init vagrant-rocky.pkr.hcl

box:    ## Build box for Rocky Linux
	@VBoxManage setproperty language C
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export TMPDIR=""`pwd`""; export PACKER_CONFIG_DIR=""`pwd`"/.config/packer"; export PACKER_PLUGIN_PATH=""`pwd`"/.config/packer/plugins"; packer build -only=virtualbox-iso.virtualbox vagrant-rocky.pkr.hcl
	@VBoxManage setproperty machinefolder default

help:
	@echo 'Usage:'
	@echo '  make <target>'
	@echo
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_0-9.-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
