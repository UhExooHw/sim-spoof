#!/system/bin/sh

# ===[ Colors (limited shell-safe for Android) ]===
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

clear

# ===[ Check environment ]===
if [ ! -d /data/adb/service.d ]; then
    echo "${RED}Magisk is not installed. Exiting.${RESET}"
    exit 1
fi

if ! cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep -qw bbr; then
    echo "${RED}Kernel does not support BBR. Exiting.${RESET}"
    exit 1
fi

if ! command -v iptables >/dev/null 2>&1; then
    echo "${RED}iptables is not installed or not available. Exiting.${RESET}"
    exit 1
fi

# ===[ Banner ]===
echo "${CYAN}========================================${RESET}"
echo "${BOLD}         ReBullet SIM Spoof${RESET}"
echo "${CYAN}========================================${RESET}"
echo "${GREEN}Environment checks passed.${RESET}"

# ===[ Operator Selection ]===
while true; do
  echo ""
  echo "${CYAN}${BOLD}Select Operator:${RESET}"
  echo "  ${GREEN}1) Beeline${RESET}"
  echo "  ${BLUE}2) MTS${RESET}"
  echo "  ${CYAN}3) Tele2 (T2)${RESET}"
  echo "  ${BOLD}4) Megafon (Russia)${RESET}"
  echo "  ${BOLD}5) Yota (Russia)${RESET}"
  echo "  ${BOLD}6) A1 (Belarus)${RESET}"
  echo "  ${BOLD}7) life:) (Belarus)${RESET}"
  echo "  ${BOLD}8) Turkcell (Turkey)${RESET}"
  echo -n "${BOLD}Enter number (1-8): ${RESET}"
  read OPERATOR_CHOICE
  case "$OPERATOR_CHOICE" in
    1)
      while true; do
        echo ""
        echo "${CYAN}${BOLD}Select Country:${RESET}"
        echo "  1) Uzbekistan (Beeline)"
        echo "  2) Russia (Beeline)"
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
          2) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
          *) echo "${RED}Invalid option. Try again.${RESET}" ;;
        esac
      done
      ;;
    2)
      while true; do
        echo ""
        echo "${CYAN}${BOLD}Select Country:${RESET}"
        echo "  1) Belarus (MTS)"
        echo "  2) Russia (MTS)"
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
          2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
          *) echo "${RED}Invalid option. Try again.${RESET}" ;;
        esac
      done
      ;;
    3)
      while true; do
        echo ""
        echo "${CYAN}${BOLD}Select Country:${RESET}"
        echo "  1) Russia (t2)"
        echo "  2) Latvia (Tele2)"
        echo -n "${BOLD}Enter number (1-2): ${RESET}"
        read COUNTRY_CHOICE
        case "$COUNTRY_CHOICE" in
          1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
          2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
          *) echo "${RED}Invalid option. Try again.${RESET}" ;;
        esac
      done
      ;;
    4)
      MCCMNC="25002" ISO="ru" TZ="Europe/Moscow" OPERATOR="Megafon"; break ;;
    5)
      MCCMNC="25011" ISO="ru" TZ="Europe/Moscow" OPERATOR="Yota"; break ;;
    6)
      MCCMNC="25701" ISO="by" TZ="Europe/Minsk" OPERATOR="A1"; break ;;
    7)
      MCCMNC="25704" ISO="by" TZ="Europe/Minsk" OPERATOR="life:)"; break ;;
    8)
      MCCMNC="28601" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell"; break ;;
    *)
      echo "${RED}Invalid option. Try again.${RESET}"
      ;;
  esac
done

# ===[ DNS Selection ]===
while true; do
  echo ""
  echo "${CYAN}${BOLD}Select DNS Provider:${RESET}"
  echo "  ${GREEN}1) Cloudflare${RESET} (1.1.1.1)"
  echo "  ${BLUE}2) Google${RESET} (8.8.8.8)"
  echo "  ${CYAN}3) Yandex${RESET} (77.88.8.88)"
  echo "  ${BOLD}4) Quad9${RESET} (9.9.9.9)"
  echo -n "${BOLD}Enter number (1-4): ${RESET}"
  read DNS_CHOICE
  case "$DNS_CHOICE" in
    1) DNS="1.1.1.1"; break ;;
    2) DNS="8.8.8.8"; break ;;
    3) DNS="77.88.8.88"; break ;;
    4) DNS="9.9.9.9"; break ;;
    *) echo "${RED}Invalid option. Try again.${RESET}" ;;
  esac
done

# ===[ Script Creation ]===
echo ""
echo "${CYAN}[+] Creating ReBullet-SIM.sh${RESET}"
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
    sleep 5
done
EOF

echo "${CYAN}[+] Creating ReBullet-TTL.sh${RESET}"
cat <<EOF > /data/adb/service.d/ReBullet-TTL.sh
#!/system/bin/sh

echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null

while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done

iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null
iptables -t mangle -C POSTROUTING -j TTL --ttl-set 64 2>/dev/null || iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53
EOF

chmod +x /data/adb/service.d/ReBullet-SIM.sh
chmod +x /data/adb/service.d/ReBullet-TTL.sh

# ===[ Summary ]===
echo ""
echo "${GREEN}[✓] Scripts installed:${RESET}"
echo "    /data/adb/service.d/ReBullet-SIM.sh"
echo "    /data/adb/service.d/ReBullet-TTL.sh"
echo ""
echo "${CYAN}Support the project on GitHub:${RESET}"
echo "${BOLD}${BLUE}https://github.com/UhExooHw/sim-spoof${RESET}"

# ===[ Reboot Prompt ]===
while true; do
  echo ""
  echo "${CYAN}Reboot required to apply changes.${RESET}"
  echo "  1) Reboot now"
  echo "  2) Reboot later"
  echo -n "${BOLD}Choose an option (1-2): ${RESET}"
  read REBOOT_CHOICE
  case "$REBOOT_CHOICE" in
    1)
      reboot
      break
      ;;
    2)
      echo "${GREEN}Reboot manually when ready.${RESET}"
      break
      ;;
    *)
      echo "${RED}Invalid choice. Try again.${RESET}"
      ;;
  esac
done
