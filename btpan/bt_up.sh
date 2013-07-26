#!/system/xbin/ash

FORCE=$1

DEVICE=tiwlan0
#DEVICE=bpn0
if [ "$#" == "3" ]; then
    DEVICE=$2
fi

WAN=`/system/xbin/ifconfig | grep tiwlan0`
if [ "$WAN" != "" ]; then
        if [ "$FORCE" != "force" ]; then
                exit 1
        fi
        ./bt_down.sh
fi

pand --killall

pand -c 00:1d:fe:7f:eb:f7 --role PAN --service PAN -e $DEVICE -o /system/usr/bin/bt_down.sh

BTPAN=`/system/xbin/ifconfig | grep $DEVICE`
if [ "$BTPAN" == "" ]; then
        sleep 5

        /system/xbin/ifconfig $DEVICE up
fi

sleep 5

pkill dhcpcd
/system/xbin/rm -Rf /data/misc/dhcp/dhcpcd-$DEVICE.*
dhcpcd $DEVICE

sleep 10

# TODO: This should be more robust...
GATEWAY=`/system/xbin/route | /system/xbin/grep default | /system/xbin/awk '{print $2}'`
setprop dhcp.$DEVICE.dns1 $GATEWAY

exit 0

