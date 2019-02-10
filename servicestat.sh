#!/bin/bash
# Check service status for user installed services
# In this example we have:
#	transmission-cli
#	samba
#	lighttpd
#	hostapd
# 
# Output preview: https://i.imgur.com/KqMEIzn.png

clear
echo
echo "Service status:"
echo "---------------"
echo 
TRANSMISSION=$(systemctl show -p ActiveState --value transmission)
SMB=$(systemctl show -p ActiveState --value smb.service)
NMB=$(systemctl show -p ActiveState --value nmb.service)
LIGHTTPD=$(systemctl show -p ActiveState --value lighttpd)
HOSTAPD=$(systemctl show -p ActiveState --value hostapd)

echo "transmission 	is: " $TRANSMISSION;
echo "lighttpd 	is: " $LIGHTTPD;
echo "hostapd 	is: " $HOSTAPD;
echo "smb 		is: " $SMB;
echo "nmb 		is: " $NMB;
echo
