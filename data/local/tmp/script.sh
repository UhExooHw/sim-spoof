#!/data/adb/ksu/bin/busybox sh

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

/data/adb/ksu/bin/busybox clear

/data/adb/ksu/bin/busybox echo "${CYAN}"
/data/adb/ksu/bin/busybox echo "╔════════════════════════════════════════╗"
/data/adb/ksu/bin/busybox echo "║             SIM Spoof Utility          ║"
/data/adb/ksu/bin/busybox echo "╚════════════════════════════════════════╝"
/data/adb/ksu/bin/busybox echo "${RESET}"

/data/adb/ksu/bin/busybox echo "${CYAN}[•] Checking environment...${RESET}"

/data/adb/ksu/bin/busybox test ! -d /data/adb/service.d && /data/adb/ksu/bin/busybox echo "${RED}[×] Root solution (Magisk/KernelSU) not installed. Exiting.${RESET}" && exit 1

BBR_SUPPORTED=false
/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_SUPPORTED=true
if [ "$BBR_SUPPORTED" = true ]; then
    /data/adb/ksu/bin/busybox echo "${GREEN}[✓] BBR supported.${RESET}"
else
    /data/adb/ksu/bin/busybox echo "${RED}[!] BBR not supported. Skipping.${RESET}"
fi

/data/adb/ksu/bin/busybox which iptables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "${RED}[×] iptables not found. Exiting.${RESET}"; exit 1; }

/data/adb/ksu/bin/busybox which ip6tables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "${RED}[×] ip6tables not found. Exiting.${RESET}"; exit 1; }

/data/adb/ksu/bin/busybox echo "${GREEN}[✓] Environment OK.${RESET}"

OPERATOR_CHOICE="$1"
case "$OPERATOR_CHOICE" in
    0)
        /data/adb/ksu/bin/busybox echo "${CYAN}Exiting...${RESET}"
        exit 0
        ;;
    1)
        COUNTRY_CHOICE="$2"
        case "$COUNTRY_CHOICE" in
            1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline" ;;
            2) MCCMNC="40101" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline" ;;
            3) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline" ;;
            *)
                /data/adb/ksu/bin/busybox echo "${RED}[×] Invalid country choice for Beeline. Use 1 (Uzbekistan), 2 (Kazakhstan), or 3 (Russia).${RESET}"
                exit 1
                ;;
        esac
        ;;
    2)
        COUNTRY_CHOICE="$2"
        case "$COUNTRY_CHOICE" in
            1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS" ;;
            2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS" ;;
            *)
                /data/adb/ksu/bin/busybox echo "${RED}[×] Invalid country choice for MTS. Use 1 (Belarus) or 2 (Russia).${RESET}"
                exit 1
                ;;
        esac
        ;;
    3)
        COUNTRY_CHOICE="$2"
        case "$COUNTRY_CHOICE" in
            1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2" ;;
            2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2" ;;
            3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2" ;;
            4) MCCMNC="24803" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2" ;;
            *)
                /data/adb/ksu/bin/busybox echo "${RED}[×] Invalid country choice for Tele2. Use 1 (Russia), 2 (Latvia), 3 (Sweden), or 4 (Estonia).${RESET}"
                exit 1
                ;;
        esac
        ;;
    4) MCCMNC="25002" ISO="ru" TZ="Europe/Moscow" OPERATOR="Megafon" ;;
    5) MCCMNC="25011" ISO="ru" TZ="Europe/Moscow" OPERATOR="Yota" ;;
    6) MCCMNC="25701" ISO="by" TZ="Europe/Minsk" OPERATOR="A1" ;;
    7) MCCMNC="25704" ISO="by" TZ="Europe/Minsk" OPERATOR="life:)" ;;
    8) MCCMNC="22803" ISO="ch" TZ="Europe/Zurich" OPERATOR="Salt" ;;
    9) MCCMNC="28601" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell" ;;
    10) MCCMNC="24491" ISO="fi" TZ="Europe/Helsinki" OPERATOR="Telia" ;;
    11) MCCMNC="26201" ISO="de" TZ="Europe/Berlin" OPERATOR="Telekom" ;;
    12) MCCMNC="20408" ISO="nl" TZ="Europe/Amsterdam" OPERATOR="KPN" ;;
    13)
        if [ $# -ne 5 ]; then
            /data/adb/ksu/bin/busybox echo "${RED}[×] Custom option requires 4 arguments: <MCCMNC> <ISO> <TZ> <OPERATOR>.${RESET}"
            /data/adb/ksu/bin/busybox echo "${RED}Example: $0 13 12345 us America/New_York CustomOperator${RESET}"
            exit 1
        fi
        MCCMNC="$2"
        ISO="$3"
        TZ="$4"
        OPERATOR="$5"
        ;;
    *)
        /data/adb/ksu/bin/busybox echo "${RED}[×] Invalid operator choice. Use 0-13.${RESET}"
        /data/adb/ksu/bin/busybox echo "${RED}Example: $0 1 2 (Beeline, Kazakhstan)${RESET}"
        exit 1
        ;;
esac

DNS_CHOICE="$3"
case "$DNS_CHOICE" in
    1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111" ;;
    2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888" ;;
    3) DNS="9.9.9.9"; DNSv6="2620:fe::fe" ;;
    4)
        if [ $# -lt 5 ]; then
            /data/adb/ksu/bin/busybox echo "${RED}[×] Custom DNS requires 2 arguments: <DNS_IPv4> <DNS_IPv6>.${RESET}"
            /data/adb/ksu/bin/busybox echo "${RED}Example: $0 1 2 4 1.2.3.4 2001:db8::1${RESET}"
            exit 1
        fi
        DNS="$4"
        DNSv6="$5"
        ;;
    *)
        /data/adb/ksu/bin/busybox echo "${RED}[×] Invalid DNS choice. Use 1 (Cloudflare), 2 (Google), 3 (Quad9), or 4 (Custom).${RESET}"
        /data/adb/ksu/bin/busybox echo "${RED}Example: $0 1 2 1 (Beeline, Kazakhstan, Cloudflare)${RESET}"
        exit 1
        ;;
esac

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "${CYAN}[+] Creating SIM-Spoof.sh...${RESET}"
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/data/adb/ksu/bin/busybox sh
while true; do
    /data/adb/ksu/bin/resetprop -n gsm.operator.iso-country ${ISO}
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.iso-country ${ISO}
    /data/adb/ksu/bin/resetprop -n gsm.operator.numeric ${MCCMNC}
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.numeric ${MCCMNC}
    /data/adb/ksu/bin/resetprop -n gsm.operator.alpha "${OPERATOR}"
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.alpha "${OPERATOR}"
    /data/adb/ksu/bin/resetprop -n persist.sys.timezone ${TZ}
    settings put global auto_time_zone 1
    settings put global private_dns_mode off
    /data/adb/ksu/bin/busybox sleep 5
done
EOF

/data/adb/ksu/bin/busybox echo "${CYAN}[+] Creating SIM-TTL.sh...${RESET}"
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/ksu/bin/busybox sh

DNS="${DNS}"
DNSv6="${DNSv6}"

/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && {
    /data/adb/ksu/bin/busybox grep -qw bbr2 /proc/sys/net/ipv4/tcp_available_congestion_control && \
        /data/adb/ksu/bin/busybox echo bbr2 > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null || \
        /data/adb/ksu/bin/busybox echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
}

while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done

while iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D POSTROUTING -j HL --hl-set 64 2>/dev/null; do :; done
while iptables -t mangle -D OUTPUT -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D OUTPUT -j HL --hl-set 64 2>/dev/null; do :; done

iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64
ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64
iptables -t mangle -A OUTPUT -j TTL --ttl-set 64
ip6tables -t mangle -A OUTPUT -j HL --hl-set 64

iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53

/data/adb/ksu/bin/resetprop -n net.eth0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.eth0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.ppp0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.ppp0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns2 ${DNS}
/data/adb/ksu/bin/busybox echo "${CYAN}[+] Creating SIM-TTL.sh...${RESET}"
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/ksu/bin/busybox sh

DNS="${DNS}"
DNSv6="${DNSv6}"

/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && {
    /data/adb/ksu/bin/busybox grep -qw bbr2 /proc/sys/net/ipv4/tcp_available_congestion_control && \
        /data/adb/ksu/bin/busybox echo bbr2 > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null || \
        /data/adb/ksu/bin/busybox echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
}

while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done

while iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D POSTROUTING -j HL --hl-set 64 2>/dev/null; do :; done
while iptables -t mangle -D OUTPUT -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D OUTPUT -j HL --hl-set 64 2>/dev/null; do :; done

iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64
ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64
iptables -t mangle -A OUTPUT -j TTL --ttl-set 64
ip6tables -t mangle -A OUTPUT -j HL --hl-set 64

iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53

/data/adb/ksu/bin/resetprop -n net.eth0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.eth0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.ppp0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.ppp0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet2.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet2.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet3.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.rmnet3.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n net.pdpbr1.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n net.pdpbr1.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan0.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan0.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan1.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan1.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan2.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan2.dns2 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan3.dns1 ${DNS}
/data/adb/ksu/bin/resetprop -n wlan3.dns2 ${DNS}
EOF

/data/adb/ksu/bin/busybox chmod +x /data/adb/service.d/SIM-*.sh

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "${GREEN}"
/data/adb/ksu/bin/busybox echo "╔══════════════════════════════════════════╗"
/data/adb/ksu/bin/busybox echo "║   [✓] Scripts successfully installed!    ║"
/data/adb/ksu/bin/busybox echo "╚══════════════════════════════════════════╝"
/data/adb/ksu/bin/busybox echo "${RESET}"

/data/adb/ksu/bin/busybox echo "${CYAN}Location: /data/adb/service.d/SIM-*.sh${RESET}"
/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "${CYAN}GitHub:${RESET} ${BLUE}https://github.com/UhExooHw/sim-spoof${RESET}"
/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "${CYAN}Reboot required to apply changes.${RESET}"
/data/adb/ksu/bin/busybox echo "${GREEN}Reboot now by running 'reboot' manually or restart the device later.${RESET}"
