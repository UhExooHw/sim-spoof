#!busybox sh

busybox clear

busybox echo "========================================="
busybox echo "         SIM Spoof Utility          "
busybox echo "========================================="

busybox echo "[•] Checking environment..."

busybox test ! -d /data/adb/service.d && busybox echo "[×] Root solution is not installed. Exiting." && exit 1
busybox test ! -d /data/adb/modules/systemless-apns && busybox echo "[×] Systemless-apns not installed. Exiting." && exit 1

CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
SERIAL_NO=""
for i in $(busybox seq 1 12); do
    RAND_INDEX=$((RANDOM % 62))
    SERIAL_NO="${SERIAL_NO}${CHARS:$RAND_INDEX:1}"
done

BBR_ALGORITHM=""
busybox grep -qw 'bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_ALGORITHM="bbr2"
busybox grep -qw 'bbr' /proc/sys/net/ipv4/tcp_available_congestion_control && [ -z "$BBR_ALGORITHM" ] && BBR_ALGORITHM="bbr"
if [ -n "$BBR_ALGORITHM" ]; then
    busybox echo "[✓] $BBR_ALGORITHM supported."
else
    busybox echo "[!] BBR/BBR2 not supported. Skipping."
fi

busybox which iptables >/dev/null 2>&1 || { busybox echo "[×] iptables not found. Exiting."; exit 1; }
busybox which ip6tables >/dev/null 2>&1 || { busybox echo "[×] ip6tables not found. Exiting."; exit 1; }
busybox echo "[✓] Environment OK."

MCCMNC="90188"
MCC="901"
MNC="88"
OPERATOR="ReBullet Internet"
busybox echo "Manual Input:"
busybox echo -n "Enter ISO (e.g., SC for Seychelles): "
read ISO
busybox echo -n "Enter Timezone (e.g., Europe/Moscow): "
read TZ
if [[ ! "$TZ" =~ "/" ]]; then
    busybox echo "[×] Invalid timezone format. Must contain a forward slash (e.g., Europe/Moscow)."
    exit 1
fi

while true; do
    busybox echo "Choose DNS Provider:"
    busybox echo "[1] Cloudflare  [2] Google  [3] Quad9"
    busybox echo "[4] Yandex  [5] Custom  [0] Back"
    busybox echo -n "Enter number (0-5): "
    read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4) DNS="77.88.8.8"; DNSv6="2a02:6b8::feed:0ff"; break ;;
        5)
            busybox echo -n "DNS IPv4: "; read DNS
            busybox echo -n "DNS IPv6: "; read DNSv6
            break
            ;;
        *) busybox echo "[!] Invalid option." ;;
    esac
done

busybox echo "[•] Downloading hosts file..."
busybox wget -O /data/adb/modules/systemless-apns/system/etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

rm /data/system/users/0/settings_ssaid.xml

RBI1=$(busybox printf "%02d" $((RANDOM % 100)))
TAC1=$(busybox printf "%06d" $((RANDOM % 1000000)))
SERIAL1=$(busybox printf "%06d" $((RANDOM % 1000000)))
CHECK_DIGIT1=$(busybox printf "%01d" $((RANDOM % 10)))
IMEI1="${RBI1}${TAC1}${SERIAL1}${CHECK_DIGIT1}"
RBI2=$(busybox printf "%02d" $((RANDOM % 100)))
TAC2=$(busybox printf "%06d" $((RANDOM % 1000000)))
SERIAL2=$(busybox printf "%06d" $((RANDOM % 1000000)))
CHECK_DIGIT2=$(busybox printf "%01d" $((RANDOM % 10)))
IMEI2="${RBI2}${TAC2}${SERIAL2}${CHECK_DIGIT2}"

busybox echo ""
busybox echo "[+] Creating SIM-Spoof.sh..."
busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

resetprop -n gsm.operator.iso-country "$ISO,$ISO"
resetprop -n gsm.sim.operator.iso-country "$ISO,$ISO"
resetprop -n gsm.operator.numeric "$MCCMNC,$MCCMNC"
resetprop -n gsm.sim.operator.numeric "$MCCMNC,$MCCMNC"
resetprop -n ro.cdma.home.operator.numeric "$MCCMNC,$MCCMNC"
resetprop -n ril.mcc.mnc0 "$MCCMNC,$MCCMNC"
resetprop -n ril.mcc.mnc1 "$MCCMNC,$MCCMNC"
resetprop -n persist.vendor.mtk.provision.mccmnc.0 "$MCCMNC,$MCCMNC"
resetprop -n persist.vendor.mtk.provision.mccmnc.1 "$MCCMNC,$MCCMNC"
resetprop -n vendor.gsm.ril.uicc.mccmnc "$MCCMNC,$MCCMNC"
resetprop -n vendor.gsm.ril.uicc.mccmnc.1 "$MCCMNC,$MCCMNC"
resetprop -n debug.tracing.mcc "$MCC"
resetprop -n debug.tracing.mnc "$MNC"
resetprop -n gsm.operator.alpha "$OPERATOR,$OPERATOR"
resetprop -n ro.cdma.home.operator.alpha "$OPERATOR,$OPERATOR"
resetprop -n gsm.sim.operator.alpha "$OPERATOR,$OPERATOR"
resetprop -n ro.carrier.name "$OPERATOR,$OPERATOR"
resetprop -n persist.sys.timezone "$TZ"
resetprop -n gsm.operator.isroaming "false,false"
resetprop -n sys.wifitracing.started "0"
resetprop -n persist.vendor.wifienhancelog "0"
resetprop -n ro.com.android.dataroaming "0"
resetprop -n persist.vendor.radio.imei  "$IMEI1"
resetprop -n persist.vendor.radio.imei1 "$IMEI1"
resetprop -n persist.vendor.radio.imei2 "$IMEI2"
resetprop -n ro.serialno "$SERIAL_NO"
resetprop -n ro.boot.serialno "$SERIAL_NO"
settings put global auto_time_zone 1
settings put global private_dns_mode off
settings put global development_settings_enabled 1
settings put global non_persistent_mac_randomization_force_enabled 1
settings put global restricted_networking_mode 0
settings put global bug_report 0
settings put global device_name Android
settings put secure tethering_allow_vpn_upstreams 1
settings put secure bluetooth_name Android

busybox sed -i -e 's#<string name="adid_key">.*</string>#<string name="adid_key">00000000-0000-0000-0000-000000000000</string>#' \
       -e 's#<int name="adid_reset_count" value=".*"/>#<int name="adid_reset_count" value="1"/>#' \
       /data/data/com.google.android.gms/shared_prefs/adid_settings.xml

EOF

busybox echo ""
busybox echo "[+] Creating SIM-Service.sh..."
busybox cat > /data/adb/service.d/SIM-Service.sh <<EOF
#!busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

while true; do
    busybox sh /data/adb/service.d/SIM-Spoof.sh
    sleep 5
done
EOF

busybox echo "[+] Creating SIM-TTL.sh..."
busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

BBR_ALGORITHM="$BBR_ALGORITHM"
DNS="$DNS"
DNSv6="$DNSv6"

if [ -n "$BBR_ALGORITHM" ]; then
    busybox echo $BBR_ALGORITHM > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
fi

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
iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination \$DNS:53 2>/dev/null || \
    iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination \$DNS:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination \$DNS:53 2>/dev/null || \
    iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination \$DNS:53

resetprop -n net.eth0.dns1 \$DNS
resetprop -n net.eth0.dns2 \$DNS
resetprop -n net.dns1 \$DNS
resetprop -n net.dns2 \$DNS
resetprop -n net.ppp0.dns1 \$DNS
resetprop -n net.ppp0.dns2 \$DNS
resetprop -n net.rmnet0.dns1 \$DNS
resetprop -n net.rmnet0.dns2 \$DNS
resetprop -n net.rmnet1.dns1 \$DNS
resetprop -n net.rmnet1.dns2 \$DNS
resetprop -n net.rmnet2.dns1 \$DNS
resetprop -n net.rmnet2.dns2 \$DNS
resetprop -n net.rmnet3.dns1 \$DNS
resetprop -n net.rmnet3.dns2 \$DNS
resetprop -n net.pdpbr1.dns1 \$DNS
resetprop -n net.pdpbr1.dns2 \$DNS
resetprop -n net.wlan0.dns1 \$DNS
resetprop -n net.wlan0.dns2 \$DNS
resetprop -n net.wlan1.dns1 \$DNS
resetprop -n net.wlan1.dns2 \$DNS
resetprop -n net.wlan2.dns1 \$DNS
resetprop -n net.wlan2.dns2 \$DNS
resetprop -n net.wlan3.dns1 \$DNS
resetprop -n net.wlan3.dns2 \$DNS
EOF

busybox chmod +x /data/adb/service.d/SIM-*.sh

busybox echo ""
busybox echo "=========================================="
busybox echo "   [✓] Scripts successfully installed!    "
busybox echo "=========================================="

busybox echo "Location: /data/adb/service.d/SIM-*.sh"
busybox echo ""
busybox echo "GitHub: https://github.com/UhExooHw/sim-spoof"

while true; do
    busybox echo ""
    busybox echo "Reboot required to apply changes."
    busybox echo "  [1] Reboot now"
    busybox echo "  [2] Reboot later"
    busybox echo -n "Choose an option (1-2): "
    read REBOOT_CHOICE
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) busybox echo "You can reboot manually later."; break ;;
        *) busybox echo "[!] Invalid choice. Try again." ;;
    esac
done
