#!/bin/bash

echo "Provisioning script $0"

nmcli -t -f NAME connection show | grep -qx eth1 || nmcli connection add type ethernet ifname eth1 con-name eth1
nmcli connection modify eth1 ipv4.method auto ipv6.method link-local
nmcli connection up eth1

nmcli connection modify eth0 ipv4.never-default yes ipv6.never-default yes
nmcli device reapply eth0 || {
	nmcli connection down eth0
	nmcli connection up eth0
}
