#!/bin/sh

# Дополнительные репозитории
sudo dnf -y install epel-release

# Установка базовых пакетов
dnf install -y @base sudo openssh-server

# Средства разработки
sudo dnf -y groupinstall 'Development Tools'
sudo dnf -y install kernel-devel kernel-modules
sudo dnf -y install dkms

# Графика
# sudo dnf -y install lightdm
sudo dnf -y groupinstall 'Server with GUI'
sudo systemctl set-default graphical.target

# Для удобства
sudo dnf install -y mc htop tmux
