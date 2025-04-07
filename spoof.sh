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

# ===[ Country Selection ]===
echo "Select Country:"
echo "  1) China (China Telecom)"
echo "  2) North Korea (Koryolink)"
echo "  3) Turkiye (Turkcell)"
echo "  4) Sweden (Tele2)"
echo "  5) Finland (Telia)"
echo "  6) Switzerland (Swisscom)"
echo "  7) Germany (Vodafone)"
echo "  8) Uzbekistan (Beeline)"
echo "  9) United States (T-Mobile)"
echo " 10) Egypt (Vodafone)"
echo -n "${BOLD}Enter number (1-10): ${RESET}"
read COUNTRY_CHOICE

case "$COUNTRY_CHOICE" in
  1)  MCCMNC="46012" ISO="cn" TZ="Asia/Shanghai" OPERATOR="China Telecom" ;;
  2)  MCCMNC="467192" ISO="kp" TZ="Asia/Pyongyang" OPERATOR="Koryolink" ;;
  3)  MCCMNC="28601" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell" ;;
  4)  MCCMNC="24014" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2" ;;
  5)  MCCMNC="24491" ISO="fi" TZ="Europe/Helsinki" OPERATOR="Telia" ;;
  6)  MCCMNC="22801" ISO="ch" TZ="Europe/Zurich" OPERATOR="Swisscom" ;;
  7)  MCCMNC="26209" ISO="de" TZ="Europe/Berlin" OPERATOR="Vodafone" ;;
  8)  MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline" ;;
  9)  MCCMNC="310010" ISO="us" TZ="America/New_York" OPERATOR="T-Mobile" ;;
 10)  MCCMNC="60202" ISO="eg" TZ="Africa/Cairo" OPERATOR="Vodafone" ;;
  *)
    echo "${RED}Invalid option.${RESET}"
    exit 1
    ;;
esac

# ===[ DNS Selection ]===
echo ""
echo "Select DNS Provider:"
echo "  1) Cloudflare (1.1.1.1)"
echo "  2) Google (8.8.8.8)"
echo "  3) Yandex (77.88.8.88)"
echo -n "${BOLD}Enter number (1-3): ${RESET}"
read DNS_CHOICE

case "$DNS_CHOICE" in
  1) DNS="1.1.1.1" ;;
  2) DNS="8.8.8.8" ;;
  3) DNS="77.88.8.88" ;;
  *)
    echo "${RED}Invalid option.${RESET}"
    exit 1
    ;;
esac

# ===[ Script Creation ]===
echo ""
echo "${CYAN}[+] Creating ReBullet-SIM.sh${RESET}"
cat <<EOF > /data/adb/service.d/ReBullet-SIM.sh
#!/system/bin/sh
while true; do
    resetprop gsm.operator.iso-country $ISO
    resetprop gsm.sim.operator.iso-country $ISO
    resetprop gsm.operator.numeric $MCCMNC
    resetprop gsm.sim.operator.numeric $MCCMNC
    resetprop gsm.operator.alpha "$OPERATOR"
    resetprop gsm.sim.operator.alpha "$OPERATOR"
    resetprop persist.sys.timezone $TZ
    sleep 30
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

iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53
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
echo "${BLUE}https://github.com/UhExooHw/sim-spoof${RESET}"

# ===[ Reboot Prompt ]===
echo ""
echo "${CYAN}Reboot required to apply changes.${RESET}"
echo "  1) Reboot now"
echo "  2) Reboot later"
echo -n "${BOLD}Choose an option (1-2): ${RESET}"
read REBOOT_CHOICE

case "$REBOOT_CHOICE" in
  1)
    reboot
    ;;
  2)
    echo "${GREEN}Reboot manually when ready.${RESET}"
    ;;
  *)
    echo "${RED}Invalid choice. Please reboot manually.${RESET}"
    ;;
esac
