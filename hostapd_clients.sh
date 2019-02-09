#!/bin/bash
# Output preview:  https://i.imgur.com/uRwLDO7.png

clear
echo
echo "-------------------------"
echo "DNS Client Leases"
echo "-------------------------"
echo "MAC Adress 	    IP Adress     Name" 
cat /var/lib/misc/dnsmasq.leases | awk '{print $2"   "$3"      "$4}'
# dhcp_release - Release a DHCP lease on a the local dnsmasq DHCP server.  <--- NOT AVAILABLE, BUT USEFUl

echo
echo "-------------------------"
echo "Count Connected Devices"
echo "-------------------------"
# as ROOT
WCLIENTNO=$(hostapd_cli all_sta | grep -c dot11RSNAStatsSTAAddress);
echo $WCLIENTNO

echo
echo "-------------------------"
echo "Connected Devices MAC's"
echo "-------------------------"
hostapd_cli all_sta | grep dot11RSNAStatsSTAAddress | awk '{print substr ($0, 26)}';
echo $WCLIENTMACS

echo
echo "-------------------------"
echo "IPv4 Network Neighbour Cache"
echo "from Kernel Address Resolution Protocol"
echo "-------------------------"
arp -e -n

echo
echo

