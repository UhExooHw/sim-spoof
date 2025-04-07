#!/system/bin/sh

clear

if [ ! -d /data/adb/service.d ]; then
    echo "Magisk is not installed. Exiting."
    exit 1
fi

if ! cat /proc/sys/net/ipv4/tcp_available_congestion_control | grep -qw bbr; then
    echo "Kernel does not support BBR. Exiting."
    exit 1
fi

if ! command -v iptables >/dev/null 2>&1; then
    echo "iptables is not installed or not available. Exiting."
    exit 1
fi

echo "======================================"
echo "         ReBullet SIM Spoof"
echo "======================================"
echo "Magisk is installed"
echo "Kernel supports BBR, continuing..."
echo "iptables is available"
echo ""

echo "Select Country:"
echo "  1) International Networks (Monaco Telecom)"
echo "  2) North Korea (Koryolink)"
echo "  3) Turkiye (Turkcell)"
echo "  4) Sweden (Tele2)"
echo "  5) Finland (Telia)"
echo "  6) Switzerland (Swisscom)"
echo "  7) Germany (Vodafone)"
echo "  8) Uzbekistan (Beeline)"
echo -n "Enter number (1-8): "
read COUNTRY_CHOICE

case "$COUNTRY_CHOICE" in
  1)
    MCCMNC="90127"
    ISO=""
    TZ="Europe/London"
    OPERATOR="Monaco Telecom"
    ;;
  2)
    MCCMNC="467192"
    ISO="kp"
    TZ="Asia/Pyongyang"
    OPERATOR="Koryolink"
    ;;
  3)
    MCCMNC="28601"
    ISO="tr"
    TZ="Europe/Istanbul"
    OPERATOR="Turkcell"
    ;;
  4)
    MCCMNC="24014"
    ISO="se"
    TZ="Europe/Stockholm"
    OPERATOR="Tele2"
    ;;
  5)
    MCCMNC="24491"
    ISO="fi"
    TZ="Europe/Helsinki"
    OPERATOR="Telia"
    ;;
  6)
    MCCMNC="22801"
    ISO="ch"
    TZ="Europe/Zurich"
    OPERATOR="Swisscom"
    ;;
  7)
    MCCMNC="26209"
    ISO="de"
    TZ="Europe/Berlin"
    OPERATOR="Vodafone"
    ;;
  8)
    MCCMNC="43404"
    ISO="uz"
    TZ="Asia/Tashkent"
    OPERATOR="Beeline"
    ;;
  *)
    echo "Invalid option."
    exit 1
    ;;
esac

echo ""
echo "Select DNS Provider:"
echo "  1) Cloudflare (1.1.1.1)"
echo "  2) Google (8.8.8.8)"
echo "  3) Yandex (77.88.8.88)"
echo -n "Enter number (1-3): "
read DNS_CHOICE

case "$DNS_CHOICE" in
  1) DNS="1.1.1.1" ;;
  2) DNS="8.8.8.8" ;;
  3) DNS="77.88.8.88" ;;
  *)
    echo "Invalid option."
    exit 1
    ;;
esac

echo ""
echo "[+] Creating ReBullet-SIM.sh"
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
    sleep 10
done
EOF

echo "[+] Creating ReBullet-TTL.sh"
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

echo ""
echo "[✓] Scripts installed:"
echo "    /data/adb/service.d/ReBullet-SIM.sh"
echo "    /data/adb/service.d/ReBullet-TTL.sh"
echo ""
echo "Support the project on GitHub:"
echo "https://github.com/UhExooHw/sim-spoof"
echo ""
echo "Reboot required to apply changes."
echo ""
echo "  1) Reboot now"
echo "  2) Reboot later"
echo -n "Choose an option (1-2): "
read REBOOT_CHOICE

case "$REBOOT_CHOICE" in
  1)
    reboot
    ;;
  2)
    echo "Reboot manually when ready."
    ;;
  *)
    echo "Invalid choice. Please reboot manually."
    ;;
esac
