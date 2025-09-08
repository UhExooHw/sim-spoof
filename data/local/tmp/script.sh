#!/system/bin/sh

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

while true; do
    /data/adb/ksu/bin/busybox echo "${BOLD}${CYAN}Select Mobile Operator:${RESET}"
    /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Beeline  ${BLUE}[2]${RESET} MTS  ${CYAN}[3]${RESET} Tele2"
    /data/adb/ksu/bin/busybox echo "  ${BOLD}[4]${RESET} Megafon  [5] Yota  [6] A1  [7] life:)"
    /data/adb/ksu/bin/busybox echo "  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom"
    /data/adb/ksu/bin/busybox echo "  [12] KPN  ${BLUE}[13]${RESET} Custom  ${RED}[0]${RESET} Exit"
    /data/adb/ksu/bin/busybox echo -n "${BOLD}Enter number (0-13): ${RESET}"
    /data/adb/ksu/bin/busybox read OPERATOR_CHOICE
    case "$OPERATOR_CHOICE" in
        0) /data/adb/ksu/bin/busybox echo "${CYAN}Exiting...${RESET}"; exit 0 ;;
        1)
            while true; do
                /data/adb/ksu/bin/busybox echo "${CYAN}Select Country:${RESET}"
                /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Uzbekistan  ${GREEN}[2]${RESET} Kazakhstan  ${BLUE}[3]${RESET} Russia  ${RED}[0]${RESET} Back"
                /data/adb/ksu/bin/busybox echo -n "${BOLD}Enter number (0-3): ${RESET}"
                /data/adb/ksu/bin/busybox read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid option.${RESET}" ;;
                esac
            done
            ;;
        2)
            while true; do
                /data/adb/ksu/bin/busybox echo "${CYAN}Select Country:${RESET}"
                /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Belarus  ${BLUE}[2]${RESET} Russia  ${RED}[0]${RESET} Back"
                /data/adb/ksu/bin/busybox echo -n "${BOLD}Enter number (0-2): ${RESET}"
                /data/adb/ksu/bin/busybox read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid option.${RESET}" ;;
                esac
            done
            ;;
        3)
            while true; do
                /data/adb/ksu/bin/busybox echo "${CYAN}Select Country:${RESET}"
                /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Russia  ${BLUE}[2]${RESET} Latvia  ${CYAN}[3]${RESET} Sweden  ${CYAN}[4]${RESET} Estonia  ${RED}[0]${RESET} Back"
                /data/adb/ksu/bin/busybox echo -n "${BOLD}Enter number (0-4): ${RESET}"
                /data/adb/ksu/bin/busybox read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
                    2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid option.${RESET}" ;;
                esac
            done
            ;;
        4) MCCMNC="25002" ISO="ru" TZ="Europe/Moscow" OPERATOR="Megafon"; break ;;
        5) MCCMNC="25011" ISO="ru" TZ="Europe/Moscow" OPERATOR="Yota"; break ;;
        6) MCCMNC="25701" ISO="by" TZ="Europe/Minsk" OPERATOR="A1"; break ;;
        7) MCCMNC="25704" ISO="by" TZ="Europe/Minsk" OPERATOR="life:)"; break ;;
        8) MCCMNC="22803" ISO="ch" TZ="Europe/Zurich" OPERATOR="Salt"; break ;;
        9) MCCMNC="28601" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell"; break ;;
        10) MCCMNC="24491" ISO="fi" TZ="Europe/Helsinki" OPERATOR="Telia"; break ;;
        11) MCCMNC="26201" ISO="de" TZ="Europe/Berlin" OPERATOR="Telekom"; break ;;
        12) MCCMNC="20408" ISO="nl" TZ="Europe/Amsterdam" OPERATOR="KPN"; break ;;
        13)
            /data/adb/ksu/bin/busybox echo "${CYAN}Manual Custom Input:${RESET}"
            /data/adb/ksu/bin/busybox echo -n "${BOLD}MCCMNC: ${RESET}"; /data/adb/ksu/bin/busybox read MCCMNC
            /data/adb/ksu/bin/busybox echo -n "${BOLD}ISO: ${RESET}"; /data/adb/ksu/bin/busybox read ISO
            /data/adb/ksu/bin/busybox echo -n "${BOLD}TimeZone: ${RESET}"; /data/adb/ksu/bin/busybox read TZ
            /data/adb/ksu/bin/busybox echo -n "${BOLD}Operator: ${RESET}"; /data/adb/ksu/bin/busybox read OPERATOR
            break
            ;;
        *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid option.${RESET}" ;;
    esac
done

while true; do
    /data/adb/ksu/bin/busybox echo "${CYAN}Choose DNS Provider:${RESET}"
    /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Cloudflare  ${BLUE}[2]${RESET} Google  ${BOLD}[3]${RESET} Quad9  ${CYAN}[4]${RESET} Custom  ${RED}[0]${RESET} Back"
    /data/adb/ksu/bin/busybox echo -n "${BOLD}Enter number (0-4): ${RESET}"
    /data/adb/ksu/bin/busybox read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4)
            /data/adb/ksu/bin/busybox echo -n "${BOLD}DNS IPv4: ${RESET}"; /data/adb/ksu/bin/busybox read DNS
            /data/adb/ksu/bin/busybox echo -n "${BOLD}DNS IPv6: ${RESET}"; /data/adb/ksu/bin/busybox read DNSv6
            break
            ;;
        *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid option.${RESET}" ;;
    esac
done

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "${CYAN}[+] Creating SIM-Spoof.sh...${RESET}"
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/system/bin/sh
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
#!/system/bin/sh

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

while true; do
    /data/adb/ksu/bin/busybox echo ""
    /data/adb/ksu/bin/busybox echo "${CYAN}Reboot required to apply changes.${RESET}"
    /data/adb/ksu/bin/busybox echo "  ${GREEN}[1]${RESET} Reboot now"
    /data/adb/ksu/bin/busybox echo "  ${BLUE}[2]${RESET} Reboot later"
    /data/adb/ksu/bin/busybox echo -n "${BOLD}Choose an option (1-2): ${RESET}"
    /data/adb/ksu/bin/busybox read REBOOT_CHOICE
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) /data/adb/ksu/bin/busybox echo "${GREEN}You can reboot manually later.${RESET}"; break ;;
        *) /data/adb/ksu/bin/busybox echo "${RED}[!] Invalid choice. Try again.${RESET}" ;;
    esac
done
