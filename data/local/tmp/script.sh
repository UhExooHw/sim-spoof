#!/system/bin/sh

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

clear

echo "${CYAN}"
echo "╔════════════════════════════════════════╗"
echo "║        ReBullet SIM Spoof Utility      ║"
echo "╚════════════════════════════════════════╝"
echo "${RESET}"

echo "${CYAN}[•] Checking environment...${RESET}"

if [ ! -d /data/adb/service.d ]; then
    echo "${RED}[×] Root solution (Magisk/KernelSU) not installed. Exiting.${RESET}"
    exit 1
fi

BBR_SUPPORTED=false
if grep -qw bbr /proc/sys/net/ipv4/tcp_available_congestion_control; then
    BBR_SUPPORTED=true
    echo "${GREEN}[✓] BBR supported.${RESET}"
else
    echo "${RED}[!] BBR not supported. Skipping.${RESET}"
fi

if ! command -v iptables >/dev/null 2>&1; then
    echo "${RED}[×] iptables not found. Exiting.${RESET}"
    exit 1
fi

if ! command -v ip6tables >/dev/null 2>&1; then
    echo "${RED}[×] ip6tables not found. Exiting.${RESET}"
    exit 1
fi

echo "${GREEN}[✓] Environment OK.${RESET}"

while true; do
    echo "${BOLD}${CYAN}Select Mobile Operator:${RESET}"
    echo "  ${GREEN}[1]${RESET} Beeline  ${BLUE}[2]${RESET} MTS  ${CYAN}[3]${RESET} Tele2"
    echo "  ${BOLD}[4]${RESET} Megafon  [5] Yota  [6] A1  [7] life:)"
    echo "  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom"
    echo "  [12] KPN  ${BLUE}[13]${RESET} Custom  ${RED}[0]${RESET} Exit"
    echo -n "${BOLD}Enter number (0-13): ${RESET}"
    read OPERATOR_CHOICE
    case "$OPERATOR_CHOICE" in
        0) echo "${CYAN}Exiting...${RESET}"; exit 0 ;;
        1)
            while true; do
                echo "${CYAN}Select Country:${RESET}"
                echo "  ${GREEN}[1]${RESET} Uzbekistan  ${GREEN}[2]${RESET} Kazakhstan  ${BLUE}[3]${RESET} Russia  ${RED}[0]${RESET} Back"
                echo -n "${BOLD}Enter number (0-3): ${RESET}"
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) echo "${RED}[!] Invalid option.${RESET}" ;;
                esac
            done
            ;;
        2)
            while true; do
                echo "${CYAN}Select Country:${RESET}"
                echo "  ${GREEN}[1]${RESET} Belarus  ${BLUE}[2]${RESET} Russia  ${RED}[0]${RESET} Back"
                echo -n "${BOLD}Enter number (0-2): ${RESET}"
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) echo "${RED}[!] Invalid option.${RESET}" ;;
                esac
            done
            ;;
        3)
            while true; do
                echo "${CYAN}Select Country:${RESET}"
                echo "  ${GREEN}[1]${RESET} Russia  ${BLUE}[2]${RESET} Latvia  ${CYAN}[3]${RESET} Sweden  ${CYAN}[4]${RESET} Estonia  ${RED}[0]${RESET} Back"
                echo -n "${BOLD}Enter number (0-4): ${RESET}"
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
                    2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) echo "${RED}[!] Invalid option.${RESET}" ;;
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
            echo "${CYAN}Manual Custom Input:${RESET}"
            echo -n "${BOLD}MCCMNC: ${RESET}"; read MCCMNC
            echo -n "${BOLD}ISO: ${RESET}"; read ISO
            echo -n "${BOLD}TimeZone: ${RESET}"; read TZ
            echo -n "${BOLD}Operator: ${RESET}"; read OPERATOR
            break
            ;;
        *) echo "${RED}[!] Invalid option.${RESET}" ;;
    esac
done

while true; do
    echo "${CYAN}Choose DNS Provider:${RESET}"
    echo "  ${GREEN}[1]${RESET} Cloudflare  ${BLUE}[2]${RESET} Google  ${BOLD}[3]${RESET} Quad9  ${CYAN}[4]${RESET} Custom  ${RED}[0]${RESET} Back"
    echo -n "${BOLD}Enter number (0-4): ${RESET}"
    read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4)
            echo -n "${BOLD}DNS IPv4: ${RESET}"; read DNS
            echo -n "${BOLD}DNS IPv6: ${RESET}"; read DNSv6
            break
            ;;
        *) echo "${RED}[!] Invalid option.${RESET}" ;;
    esac
done

echo ""
echo "${CYAN}[+] Creating ReBullet-SIM.sh...${RESET}"
cat > /data/adb/service.d/ReBullet-SIM.sh <<EOF
#!/system/bin/sh
while true; do
    resetprop -n gsm.operator.iso-country ${ISO}
    resetprop -n gsm.sim.operator.iso-country ${ISO}
    resetprop -n gsm.operator.numeric ${MCCMNC}
    resetprop -n gsm.sim.operator.numeric ${MCCMNC}
    resetprop -n gsm.operator.alpha "${OPERATOR}"
    resetprop -n gsm.sim.operator.alpha "${OPERATOR}"
    resetprop -n persist.sys.timezone ${TZ}
    settings put global auto_time_zone 1
    settings put global private_dns_mode off
    sleep 5
done
EOF

echo "${CYAN}[+] Creating ReBullet-TTL.sh...${RESET}"
cat > /data/adb/service.d/ReBullet-TTL.sh <<EOF
#!/system/bin/sh

DNS="${DNS}"
DNSv6="${DNSv6}"

if grep -qw bbr /proc/sys/net/ipv4/tcp_available_congestion_control; then
    echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
fi

while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done
while ip6tables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while ip6tables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done

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
ip6tables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination [${DNSv6}]:53 2>/dev/null || ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination [${DNSv6}]:53
ip6tables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination [${DNSv6}]:53 2>/dev/null || ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination [${DNSv6}]:53

resetprop -n net.eth0.dns1 ${DNS}
resetprop -n net.eth0.dns2 ${DNS}
resetprop -n net.dns1 ${DNS}
resetprop -n net.dns2 ${DNS}
resetprop -n net.ppp0.dns1 ${DNS}
resetprop -n net.ppp0.dns2 ${DNS}
resetprop -n net.rmnet0.dns1 ${DNS}
resetprop -n net.rmnet0.dns2 ${DNS}
resetprop -n net.rmnet1.dns1 ${DNS}
resetprop -n net.rmnet1.dns2 ${DNS}
resetprop -n net.rmnet2.dns1 ${DNS}
resetprop -n net.rmnet2.dns2 ${DNS}
resetprop -n net.rmnet3.dns1 ${DNS}
resetprop -n net.rmnet3.dns2 ${DNS}
resetprop -n net.pdpbr1.dns1 ${DNS}
resetprop -n net.pdpbr1.dns2 ${DNS}
resetprop -n wlan0.dns1 ${DNS}
resetprop -n wlan0.dns2 ${DNS}
resetprop -n wlan1.dns1 ${DNS}
resetprop -n wlan1.dns2 ${DNS}
resetprop -n wlan2.dns1 ${DNS}
resetprop -n wlan2.dns2 ${DNS}
resetprop -n wlan3.dns1 ${DNS}
resetprop -n wlan3.dns2 ${DNS}
EOF

chmod +x /data/adb/service.d/ReBullet-*.sh

# ===[ Summary ]===
echo ""
echo "${GREEN}"
echo "╔══════════════════════════════════════════╗"
echo "║   [✓] Scripts successfully installed!    ║"
echo "╚══════════════════════════════════════════╝"
echo "${RESET}"

echo "${CYAN}Location: /data/adb/service.d/ReBullet-*.sh${RESET}"
echo ""
echo "${CYAN}GitHub:${RESET} ${BLUE}https://github.com/UhExooHw/sim-spoof${RESET}"

while true; do
  echo ""
  echo "${CYAN}Reboot required to apply changes.${RESET}"
  echo "  ${GREEN}[1]${RESET} Reboot now"
  echo "  ${BLUE}[2]${RESET} Reboot later"
  echo -n "${BOLD}Choose an option (1-2): ${RESET}"
  read REBOOT_CHOICE
  case "$REBOOT_CHOICE" in
    1) reboot; break ;;
    2) echo "${GREEN}You can reboot manually later.${RESET}"; break ;;
    *) echo "${RED}[!] Invalid choice. Try again.${RESET}" ;;
  esac
done
