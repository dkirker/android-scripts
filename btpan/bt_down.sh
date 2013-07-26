#!/system/xbin/ash

/system/xbin/route del -net 0.0.0.0 dev tiwlan0

pkill dhcpcd                                     
/system/xbin/rm -Rf /data/misc/dhcp/dhcpcd-tiwlan0.*
dhcpcd tiwlan0

exit 0

