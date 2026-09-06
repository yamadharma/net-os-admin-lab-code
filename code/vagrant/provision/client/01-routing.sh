#!/bin/bash

echo "Provisioning script $0"

# Rocky 10: соединения NetworkManager называются eth0/eth1, а не "System eth1".
# eth1 (внутренняя сеть, адрес по DHCP) настраиваем сами: профиль с IPv6 link-local,
# чтобы активация не ждала DHCP-сервер — до лабы 3 его нет, IPv4 ищет его в фоне.
# Шлюз для DHCP-профиля задать нельзя (NetworkManager: "gateway cannot be set if there
# are no addresses configured"), его выдаст DHCP-сервер в лабе 3.
nmcli -t -f NAME connection show | grep -qx eth1 || nmcli connection add type ethernet ifname eth1 con-name eth1
nmcli connection modify eth1 ipv4.method auto ipv6.method link-local
nmcli connection up eth1

# eth0 (управление): не маршрут по умолчанию; reapply вместо down/up, чтобы не рвать ssh
nmcli connection modify eth0 ipv4.never-default yes ipv6.never-default yes
nmcli device reapply eth0 || { nmcli connection down eth0; nmcli connection up eth0; }
