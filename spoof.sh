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

echo "${GREEN}[✓] Environment OK.${RESET}"

# ===[ Operator Selection ]===
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
  echo -n "${BOLD}Enter number (1-9): ${RESET}"
  read OPERATOR_CHOICE
  case "$OPERATOR_CHOICE" in
    1)
      while true; do
        echo ""
        echo "${CYAN}Select Country:${RESET}"
        echo "  ${GREEN}[1]${RESET} Uzbekistan (Beeline)"
        echo "  ${BLUE}[2]${RESET} Russia (Beeline)"
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
          2) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
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
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
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
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
          2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
          3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
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
  echo -n "${BOLD}Enter number (1-3): ${RESET}"
  read DNS_CHOICE
  case "$DNS_CHOICE" in
    1) DNS="1.1.1.1"; DOT_HOST="one.one.one.one"; break ;;
    2) DNS="8.8.8.8"; DOT_HOST="dns.google"; break ;;
    3) DNS="9.9.9.9"; DOT_HOST="dns.quad9.net"; break ;;
    *) echo "${RED}[!] Invalid option. Try again.${RESET}" ;;
  esac
done


# ===[ Script Creation ]===
echo ""
echo "${CYAN}[+] Creating ReBullet-SIM.sh...${RESET}"
cat > /data/adb/service.d/ReBullet-SIM.sh <<EOF
#!/system/bin/sh
while true; do
    resetprop gsm.operator.iso-country ${ISO}
    resetprop gsm.sim.operator.iso-country ${ISO}
    resetprop gsm.operator.numeric ${MCCMNC}
    resetprop gsm.sim.operator.numeric ${MCCMNC}
    resetprop gsm.operator.alpha "${OPERATOR}"
    resetprop gsm.sim.operator.alpha "${OPERATOR}"
    resetprop persist.sys.timezone ${TZ}
    settings put global private_dns_mode hostname
    settings put global private_dns_specifier "${DOT_HOST}"
    sleep 5
done
EOF

echo "${CYAN}[+] Creating ReBullet-TTL.sh...${RESET}"
cat > /data/adb/service.d/ReBullet-TTL.sh <<EOF
#!/system/bin/sh

# Enable BBR if available
if grep -qw bbr /proc/sys/net/ipv4/tcp_available_congestion_control; then
    echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
fi

# Flush previous rules
while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done
iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null

# Apply TTL spoof
iptables -t mangle -C POSTROUTING -j TTL --ttl-set 64 2>/dev/null || iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

# Redirect DNS
iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53
EOF

chmod +x /data/adb/service.d/ReBullet-SIM.sh
chmod +x /data/adb/service.d/ReBullet-TTL.sh

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
