#!/system/xbin/ash

/system/xbin/route del -net 0.0.0.0 dev bpn0

pkill dhcpcd
/system/xbin/rm -Rf /data/misc/dhcp/dhcpcd-bpn0.*
dhcpcd tiwlan0

exit 0

