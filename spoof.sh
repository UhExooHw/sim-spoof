#!/system/bin/sh

# ===[ Colors (shell-safe for Android) ]===
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

clear

# ===[ Banner ]===
echo "${CYAN}"
echo "╔════════════════════════════════════════╗"
echo "║        ReBullet SIM Spoof Utility      ║"
echo "╚════════════════════════════════════════╝"
echo "${RESET}"

# ===[ Environment Check ]===
echo "${CYAN}[•] Checking environment...${RESET}"

if [ ! -d /data/adb/service.d ]; then
    echo "${RED}[×] Magisk is not installed. Exiting.${RESET}"
    exit 1
fi

BBR_SUPPORTED=false
if cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep -qw bbr; then
    BBR_SUPPORTED=true
    echo "${GREEN}[✓] BBR is supported by the kernel.${RESET}"
else
    echo "${RED}[!] BBR is not supported. Skipping activation.${RESET}"
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

# ===[ Operator & Country Selection ]===
while true; do
  echo ""
  echo "${BOLD}${CYAN}Select Mobile Operator:${RESET}"
  echo "  ${GREEN}[1]${RESET} Beeline"
  echo "  ${BLUE}[2]${RESET} MTS"
  echo "  ${CYAN}[3]${RESET} Tele2 (T2)"
  echo "  ${BOLD}[4]${RESET} Megafon (Russia)"
  echo "  ${BOLD}[5]${RESET} Yota (Russia)"
  echo "  ${BOLD}[6]${RESET} A1 (Belarus)"
  echo "  ${BOLD}[7]${RESET} life:) (Belarus)"
  echo "  ${BOLD}[8]${RESET} Salt (Switzerland)"
  echo "  ${BOLD}[9]${RESET} Turkcell (Turkey)"
  echo "  ${BOLD}[10]${RESET} Telia (Finland)"
  echo "  ${BOLD}[11]${RESET} Telekom (Germany)"
  echo "  ${BOLD}[12]${RESET} KPN (Netherlands)"
  echo "  ${BLUE}[13]${RESET} Custom (manual input)"
  echo "  ${RED}[0]${RESET} Exit"
  echo -n "${BOLD}Enter number (0-13): ${RESET}"
  read OPERATOR_CHOICE
  case "$OPERATOR_CHOICE" in
    0) echo "${CYAN}Exiting...${RESET}"; exit 0 ;;
    1)
      while true; do
        echo ""
        echo "${CYAN}Select Country:${RESET}"
        echo "  ${GREEN}[1]${RESET} Uzbekistan (Beeline)"
        echo "  ${GREEN}[2]${RESET} Kazakhstan (Beeline)"
        echo "  ${BLUE}[3]${RESET} Russia (Beeline)"
        echo "  ${RED}[0]${RESET} Back"
        echo -n "${BOLD}Enter number (0-3): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          0) break ;;
          1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
          2) MCCMNC="40101" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
          3) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
          *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
        esac
      done
      ;;
    2)
      while true; do
        echo ""
        echo "${CYAN}Select Country:${RESET}"
        echo "  ${GREEN}[1]${RESET} Belarus (MTS)"
        echo "  ${BLUE}[2]${RESET} Russia (MTS)"
        echo "  ${RED}[0]${RESET} Back"
        echo -n "${BOLD}Enter number (0-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          0) break ;;
          1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
          2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
          *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
        esac
      done
      ;;
    3)
      while true; do
        echo ""
        echo "${CYAN}Select Country:${RESET}"
        echo "  ${GREEN}[1]${RESET} Russia (T2)"
        echo "  ${BLUE}[2]${RESET} Latvia (Tele2)"
        echo "  ${CYAN}[3]${RESET} Sweden (Tele2)"
        echo "  ${CYAN}[4]${RESET} Estonia (Tele2)"
        echo "  ${RED}[0]${RESET} Back"
        echo -n "${BOLD}Enter number (0-4): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          0) break ;;
          1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
          2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
          3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
          4) MCCMNC="24803" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
          *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
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
      echo -n "${BOLD}ISO (e.g. ru): ${RESET}"; read ISO
      echo -n "${BOLD}TimeZone (e.g. Europe/Moscow): ${RESET}"; read TZ
      echo -n "${BOLD}Operator Name: ${RESET}"; read OPERATOR
      break
      ;;
    *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
  esac
done

# ===[ DNS Selection ]===
while true; do
  echo ""
  echo "${CYAN}Choose DNS Provider:${RESET}"
  echo "  ${GREEN}[1]${RESET} Cloudflare (1.1.1.1)"
  echo "  ${BLUE}[2]${RESET} Google     (8.8.8.8)"
  echo "  ${BOLD}[3]${RESET} Quad9      (9.9.9.9)"
  echo "  ${CYAN}[4]${RESET} Custom DNS"
  echo "  ${RED}[0]${RESET} Back"
  echo -n "${BOLD}Enter number (0-4): ${RESET}"
  read DNS_CHOICE
case "$DNS_CHOICE" in
  0) exec "$0" ;;
  1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; DOT_HOST="one.one.one.one"; break ;;
  2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; DOT_HOST="dns.google"; break ;;
  3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; DOT_HOST="dns.quad9.net"; break ;;
  4)
    echo -n "${BOLD}Enter DNS IPv4: ${RESET}"; read DNS
    echo -n "${BOLD}Enter DNS IPv6: ${RESET}"; read DNSv6
    echo -n "${BOLD}Enter DoT hostname: ${RESET}"; read DOT_HOST
    break
    ;;
  *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
esac
done

# ===[ Script Creation ]===
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
    settings put global private_dns_mode hostname
    settings put global private_dns_specifier "${DOT_HOST}"
    settings put global auto_time_zone 1
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

iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null
iptables -t mangle -C POSTROUTING -j TTL --ttl-set 64 2>/dev/null || iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

ip6tables -t mangle -D POSTROUTING -j HL --hl-set 64 2>/dev/null
ip6tables -t mangle -C POSTROUTING -j HL --hl-set 64 2>/dev/null || ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64

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
EOF


chmod +x /data/adb/service.d/ReBullet-*.sh

# ===[ Summary ]===
echo ""
echo "${GREEN}"
echo "╔══════════════════════════════════════════╗"
echo "║   [✓] Scripts successfully installed!    ║"
echo "║   Loaded on boot via Magisk service.d    ║"
echo "╚══════════════════════════════════════════╝"
echo "${RESET}"

echo "${CYAN}Location: /data/adb/service.d/ReBullet-*.sh${RESET}"
echo ""
echo "${CYAN}GitHub:${RESET} ${BLUE}https://github.com/UhExooHw/sim-spoof${RESET}"

# ===[ Reboot Prompt ]===
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
