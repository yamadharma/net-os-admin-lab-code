## Конфигурация
BOX_NAME := rockylinux10
VAGRANT_FILE ?= Vagrantfile
## Set your provider
# PROVIDERS := virtualbox libvirt
PROVIDERS := virtualbox

# Цели по умолчанию
.DEFAULT_GOAL := help

.PHONY: version

help:
	@echo 'Usage:'
	@echo '  make <target>'
	@echo
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_0-9.-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

check-virtualbox:  ## Check VirtualBox
	@which VBoxManage >/dev/null 2>&1 || (echo "VirtualBox is not installed"; exit 1)

check-libvirt:  ## Check libvirt
	@which virsh >/dev/null 2>&1 || (echo "libvirt is not installed"; exit 1)
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; vagrant plugin list | grep -q vagrant-libvirt || (echo "The vagrant-libvirt plugin is not installed"; exit 1)

plugins:	## Install plugins
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-libvirt
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; vagrant plugin install --plugin-clean-sources --plugin-source https://rubygems.org vagrant-vbguest
	touch plugins

addbox:	## Add the built box to Vagrant
	@for provider in $(PROVIDERS); do \
		export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; vagrant box add $(BOX_NAME) vagrant-$$provider-$(BOX_NAME)-x86_64.box ; \
		[[ $$provider == "libvirt" ]] && ( mkdir -p vm ; virsh pool-define-as --name vagrant --type dir --target "`pwd`"/vm ; virsh pool-start vagrant ) ; \
	done

server-up: plugins	## Start server
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant up --provider=virtualbox server
	@VBoxManage setproperty machinefolder default

client-up: plugins	## Start client
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant up --provider=virtualbox client
	@VBoxManage setproperty machinefolder default

server-halt: plugins	## Stop server
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant halt server
	@VBoxManage setproperty machinefolder default

client-halt: plugins	## Stop client
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant halt client
	@VBoxManage setproperty machinefolder default

server-provision: plugins	## Start and provision server
	@for provider in $(PROVIDERS); do \
		VBoxManage setproperty machinefolder "`pwd`"/vm; \
		export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant up --provider=$$provider server --provision ; \
		VBoxManage setproperty machinefolder default ;\
	done

client-provision: plugins	## Start and provision client
	@for provider in $(PROVIDERS); do \
		VBoxManage setproperty machinefolder "`pwd`"/vm ; \
		export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant up --provider=$$provider client --provision ; \
		VBoxManage setproperty machinefolder default ; \
	done

server-destroy:	## Destroy server
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant destroy -f server
	@VBoxManage setproperty machinefolder default

client-destroy:	## Destroy client
	@VBoxManage setproperty machinefolder "`pwd`"/vm
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant destroy -f client
	@VBoxManage setproperty machinefolder default

status: plugins  ## Show status of all VMs
	@for provider in $(PROVIDERS); do \
		echo "=== Provider: $$provider ==="; \
		export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; vagrant status --machine-readable --provider=$$provider | awk -F, '$$2 == "default" && $$3 == "state" {print $$4}'; \
	done

destroy: server-destroy client-destroy  ## Destroy all VM

clean: destroy  ## Full clean
	rm -rf .vagrant
	@export VAGRANT_HOME="`pwd`"/.vagrant.d; export VAGRANT_DOTFILE_PATH="`pwd`"/.vagrant; export VBOX_USER_HOME="`pwd`"/.vbox; export VBOX_INSTALL_PATH="`pwd`"/vm; vagrant box remove $(BOX_NAME) --all --force || true
	@virsh pool-delete vagrant ; virsh pool-undefine vagrant
