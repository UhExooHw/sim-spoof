#!/system/bin/sh
# Author: ReBullet

echo $(cat /proc/sys/net/ipv4/tcp_available_congestion_control) | grep -qw bbr && echo bbr > /proc/sys/net/ipv4/tcp_congestion_control

iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null
iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53 2>/dev/null
iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53 2>/dev/null
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination 8.8.8.8:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination 8.8.8.8:53
