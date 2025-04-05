#!/system/bin/sh

clear

echo "========= ReBullet SIM Spoof ========="
echo ""
echo "Select Country:"
echo "1) Kazakhstan"
echo "2) Uzbekistan"
echo "3) Kyrgyzstan"
echo "4) Russia"
echo -n "Enter number (1-4): "
read COUNTRY_CHOICE

case "$COUNTRY_CHOICE" in
  1)
    MCCMNC="40101"
    ISO="kz"
    TZ="Asia/Almaty"
    ;;
  2)
    MCCMNC="43404"
    ISO="uz"
    TZ="Asia/Tashkent"
    ;;
  3)
    MCCMNC="43701"
    ISO="kg"
    TZ="Asia/Bishkek"
    ;;
  4)
    MCCMNC="25099"
    ISO="ru"
    TZ="Europe/Moscow"
    ;;
  *)
    echo "Invalid option."
    exit 1
    ;;
esac

echo ""
echo "Select DNS Provider:"
echo "1) Cloudflare (1.1.1.1)"
echo "2) Google (8.8.8.8)"
echo "3) Yandex (77.88.8.88)"
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

mkdir -p /data/adb/service.d

echo "Creating ReBullet-SIM.sh..."
cat <<EOF > /data/adb/service.d/ReBullet-SIM.sh
#!/system/bin/sh
while true; do
    resetprop gsm.operator.iso-country $ISO
    resetprop gsm.sim.operator.iso-country $ISO
    resetprop gsm.operator.numeric $MCCMNC
    resetprop gsm.sim.operator.numeric $MCCMNC
    resetprop gsm.operator.alpha "Beeline"
    resetprop gsm.sim.operator.alpha "Beeline"
    resetprop persist.sys.timezone $TZ
    sleep 10
done
EOF

echo "Creating ReBullet-TTL.sh..."
cat <<EOF > /data/adb/service.d/ReBullet-TTL.sh
#!/system/bin/sh

echo \$(cat /proc/sys/net/ipv4/tcp_available_congestion_control) | grep -qw bbr && echo bbr > /proc/sys/net/ipv4/tcp_congestion_control

iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null
iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null
iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null
iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53
iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53
EOF

chmod +x /data/adb/service.d/ReBullet-SIM.sh
chmod +x /data/adb/service.d/ReBullet-TTL.sh

echo ""
echo "Scripts installed successfully:"
echo "- /data/adb/service.d/ReBullet-SIM.sh"
echo "- /data/adb/service.d/ReBullet-TTL.sh"
echo ""
echo "If you like this tool, please visit and star the GitHub repository:"
echo "https://github.com/UhExooHw/sim-spoof"
echo ""
echo "To apply the settings, a reboot is required."
echo ""
echo "1) Reboot now"
echo "2) Reboot later"
echo -n "Choose an option (1-2): "
read REBOOT_CHOICE

case "$REBOOT_CHOICE" in
  1)
    reboot
    ;;
  2)
    echo "Reboot manually later to apply the settings."
    ;;
  *)
    echo "Invalid option. Please reboot manually."
    ;;
esac
