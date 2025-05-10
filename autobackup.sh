#!/bin/bash


# Shadowsocks Backup telegram Bot

link="$(curl -F "file=@/usr/local/shadowsocksr/mudb.json" "https://file.io" | jq ".link")"
id=991931132
token="6971298468:AAF_OsyYhK5cFJSFVvHopnF1TKGL_raP-1w"
domainopen=$(cat /etc/openvpn/server/client-common.txt | sed -n 4p | cut -d ' ' -f 2)
domain=$(cat /usr/local/shadowsocksr/userapiconfig.py | grep "SERVER_PUB_ADDR = " | awk -F "[']" '{print $2}')
ip=$(curl ifconfig.me)

if [ -e /usr/local/shadowsocksr/mudb.json ] then
    wget -qO /dev/null "https://api.telegram.org/bot$token/sendMessage?chat_id=$id&text=$ip+$domain+ShadowSocks+$link"
else
    echo Bad
fi
if [ -e /usr/local/shadowsocksr/mudb.json ] then
    curl -F "chat_id=$id" -F document=@/usr/local/shadowsocksr/mudb.json https://api.telegram.org/bot$token/sendDocument?caption=$domain
else
    echo Bad
fi

# OpenVPN Backup telegram Bot

mkdir -p /etc/openvpn/clients
cp /root/*.ovpn /etc/openvpn/clients
cd /etc
tar -czvf "openvpn.tar.gz" "openvpn"
linkf="$(curl -F "file=@/etc/openvpn.tar.gz" "https://file.io" | jq ".link")"

if [ -e /etc/openvpn/server/server.conf ] then
    wget -qO /dev/null "https://api.telegram.org/bot$token/sendMessage?chat_id=$id&text=$ip+$domainopen+OpenVPN+$linkf"
else
    echo Bad
fi
if [ -e /etc/openvpn/server/server.conf ] then
    curl -F "chat_id=$id" -F document=@/etc/openvpn.tar.gz https://api.telegram.org/bot$token/sendDocument?caption=$domainopen
else
    echo Bad
fi

rm /etc/openvpn.tar.gz
