#!/system/xbin/ash

DEVICE=tiwlan0
#DEVICE=bpn0

/system/xbin/route del -net 0.0.0.0 dev $DEVICE

pand --killall

/system/xbin/ifconfig $DEVICE down

pkill dhcpcd
/system/xbin/rm -Rf /data/misc/dhcp/dhcpcd-$DEVICE.*
dhcpcd tiwlan0

exit 0


