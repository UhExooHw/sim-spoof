#!/data/adb/ap/bin/busybox sh

/data/adb/ap/bin/busybox clear

/data/adb/ap/bin/busybox echo "========================================="
/data/adb/ap/bin/busybox echo "         SIM Spoof Utility          "
/data/adb/ap/bin/busybox echo "========================================="

/data/adb/ap/bin/busybox echo "[•] Checking environment..."

/data/adb/ap/bin/busybox test ! -d /data/adb/service.d && /data/adb/ap/bin/busybox echo "[×] Root solution APatch not installed. Exiting." && exit 1
/data/adb/ap/bin/busybox test ! -d /data/adb/modules/bindhosts/system/etc && /data/adb/ap/bin/busybox echo "[×] Bindhosts hosts not installed. Exiting." && exit 1

NEW_ANDROID_ID=$(/data/adb/ap/bin/busybox hexdump -n8 -ve '/1 "%02x"' /dev/urandom)
BBR_ALGORITHM=""
/data/adb/ap/bin/busybox grep -qw 'bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_ALGORITHM="bbr2"
/data/adb/ap/bin/busybox grep -qw 'bbr' /proc/sys/net/ipv4/tcp_available_congestion_control && [ -z "$BBR_ALGORITHM" ] && BBR_ALGORITHM="bbr"
if [ -n "$BBR_ALGORITHM" ]; then
    /data/adb/ap/bin/busybox echo "[✓] $BBR_ALGORITHM supported."
else
    /data/adb/ap/bin/busybox echo "[!] BBR/BBR2 not supported. Skipping."
fi

/data/adb/ap/bin/busybox which iptables >/dev/null 2>&1 || { /data/adb/ap/bin/busybox echo "[×] iptables not found. Exiting."; exit 1; }
/data/adb/ap/bin/busybox which ip6tables >/dev/null 2>&1 || { /data/adb/ap/bin/busybox echo "[×] ip6tables not found. Exiting."; exit 1; }
/data/adb/ap/bin/busybox echo "[✓] Environment OK."

while true; do
    /data/adb/ap/bin/busybox echo "Select Mobile Operator:"
    /data/adb/ap/bin/busybox echo "  [1] Beeline  [2] MTS  [3] Tele2   [4] Megafon"
    /data/adb/ap/bin/busybox echo "  [5] Yota  [6] Velcom  [7] Life:)   [8] Salt"
    /data/adb/ap/bin/busybox echo "  [9] Turkcell  [10] Tele Finland  [11] Telekom   [12] KPN"
    /data/adb/ap/bin/busybox echo "  [13] Airtel  [14] Kyivstar  [15] Test   [16] Irancell"
    /data/adb/ap/bin/busybox echo "  [17] Custom  [0] Exit"
    /data/adb/ap/bin/busybox echo -n "Enter number (0-17): "
    read OPERATOR_CHOICE
    case "$OPERATOR_CHOICE" in
        0) /data/adb/ap/bin/busybox echo "Exiting..."; exit 0 ;;
        1)
            while true; do
                /data/adb/ap/bin/busybox echo "Select Country:"
                /data/adb/ap/bin/busybox echo "  [1] Uzbekistan  [2] Kazakhstan  [3] Russia  [0] Back"
                /data/adb/ap/bin/busybox echo -n "Enter number (0-3): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" MCC="434" MNC="04" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" MCC="401" MNC="01" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" MCC="250" MNC="99" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) /data/adb/ap/bin/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        2)
            while true; do
                /data/adb/ap/bin/busybox echo "Select Country:"
                /data/adb/ap/bin/busybox echo "  [1] Belarus  [2] Russia  [0] Back"
                /data/adb/ap/bin/busybox echo -n "Enter number (0-2): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" MCC="257" MNC="02" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" MCC="250" MNC="01" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) /data/adb/ap/bin/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        3)
            while true; do
                /data/adb/ap/bin/busybox echo "Select Country:"
                /data/adb/ap/bin/busybox echo "  [1] Russia  [2] Latvia  [3] Sweden  [4] Estonia  [0] Back"
                /data/adb/ap/bin/busybox echo -n "Enter number (0-4): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" MCC="250" MNC="20" ISO="ru" TZ="Europe/Moscow" OPERATOR="Tele2 RU"; break 2 ;;
                    2) MCCMNC="24702" MCC="247" MNC="02" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" MCC="240" MNC="07" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" MCC="248" MNC="03" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) /data/adb/ap/bin/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        4) MCCMNC="25002" MCC="250" MNC="02" ISO="ru" TZ="Europe/Moscow" OPERATOR="Megafon"; break ;;
        5) MCCMNC="25011" MCC="250" MNC="11" ISO="ru" TZ="Europe/Moscow" OPERATOR="Yota"; break ;;
        6) MCCMNC="25701" MCC="257" MNC="01" ISO="by" TZ="Europe/Minsk" OPERATOR="Velcom"; break ;;
        7) MCCMNC="25704" MCC="257" MNC="04" ISO="by" TZ="Europe/Minsk" OPERATOR="life:)"; break ;;
        8) MCCMNC="22803" MCC="228" MNC="03" ISO="ch" TZ="Europe/Zurich" OPERATOR="Salt"; break ;;
        9) MCCMNC="28601" MCC="286" MNC="01" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell"; break ;;
        10) MCCMNC="24491" MCC="244" MNC="91" ISO="fi" TZ="Europe/Helsinki" OPERATOR="Tele Finland"; break ;;
        11) MCCMNC="26201" MCC="262" MNC="01" ISO="de" TZ="Europe/Berlin" OPERATOR="Telekom"; break ;;
        12) MCCMNC="20408" MCC="204" MNC="08" ISO="nl" TZ="Europe/Amsterdam" OPERATOR="KPN"; break ;;
        13) MCCMNC="40402" MCC="404" MNC="02" ISO="in" TZ="Asia/Kolkata" OPERATOR="Airtel"; break ;;
        14) MCCMNC="25503" MCC="255" MNC="03" ISO="ua" TZ="Europe/Kyiv" OPERATOR="Kyivstar"; break ;;
        15) MCCMNC="00101" MCC="001" MNC="01" ISO="aq" TZ="Antarctica/Vostok" OPERATOR="Test"; break ;;
        16) MCCMNC="43235" MCC="432" MNC="35" ISO="ir" TZ="Asia/Tehran" OPERATOR="Irancell"; break ;;
        17)
            /data/adb/ap/bin/busybox echo "Manual Custom Input:"
            /data/adb/ap/bin/busybox echo -n "MCCMNC: "; read MCCMNC
            /data/adb/ap/bin/busybox echo -n "MCC: "; read MCC
            /data/adb/ap/bin/busybox echo -n "MNC: "; read MNC
            /data/adb/ap/bin/busybox echo -n "ISO: "; read ISO
            /data/adb/ap/bin/busybox echo -n "TimeZone: "; read TZ
            /data/adb/ap/bin/busybox echo -n "Operator: "; read OPERATOR
            break
            ;;
        *) /data/adb/ap/bin/busybox echo "[!] Invalid option." ;;
    esac
done

while true; do
    /data/adb/ap/bin/busybox echo "Choose DNS Provider:"
    /data/adb/ap/bin/busybox echo "[1] Cloudflare  [2] Google  [3] Quad9"
    /data/adb/ap/bin/busybox echo "[4] Yandex  [5] Custom  [0] Back"
    /data/adb/ap/bin/busybox echo -n "Enter number (0-5): "
    read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4) DNS="77.88.8.8"; DNSv6="2a02:6b8::feed:0ff"; break ;;
        5)
            /data/adb/ap/bin/busybox echo -n "DNS IPv4: "; read DNS
            /data/adb/ap/bin/busybox echo -n "DNS IPv6: "; read DNSv6
            break
            ;;
        *) /data/adb/ap/bin/busybox echo "[!] Invalid option." ;;
    esac
done

/data/adb/ap/bin/busybox echo "[•] Downloading hosts file..."
/data/adb/ap/bin/busybox wget -O /data/adb/modules/bindhosts/system/etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts || { /data/adb/ap/bin/busybox echo "[×] Failed to download hosts file."; exit 1; }

RBI1=$(/data/adb/ap/bin/busybox printf "%02d" $((RANDOM % 100)))
TAC1=$(/data/adb/ap/bin/busybox printf "%06d" $((RANDOM % 1000000)))
SERIAL1=$(/data/adb/ap/bin/busybox printf "%06d" $((RANDOM % 1000000)))
CHECK_DIGIT1=$(/data/adb/ap/bin/busybox printf "%01d" $((RANDOM % 10)))
IMEI1="${RBI1}${TAC1}${SERIAL1}${CHECK_DIGIT1}"
RBI2=$(/data/adb/ap/bin/busybox printf "%02d" $((RANDOM % 100)))
TAC2=$(/data/adb/ap/bin/busybox printf "%06d" $((RANDOM % 1000000)))
SERIAL2=$(/data/adb/ap/bin/busybox printf "%06d" $((RANDOM % 1000000)))
CHECK_DIGIT2=$(/data/adb/ap/bin/busybox printf "%01d" $((RANDOM % 10)))
IMEI2="${RBI2}${TAC2}${SERIAL2}${CHECK_DIGIT2}"

/data/adb/ap/bin/busybox echo ""
/data/adb/ap/bin/busybox echo "[+] Creating SIM-Spoof.sh..."
/data/adb/ap/bin/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/data/adb/ap/bin/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

/data/adb/ap/bin/resetprop -n gsm.operator.iso-country "$ISO,$ISO"
/data/adb/ap/bin/resetprop -n gsm.sim.operator.iso-country "$ISO,$ISO"
/data/adb/ap/bin/resetprop -n gsm.operator.numeric "$MCCMNC,$MCCMNC"
/data/adb/ap/bin/resetprop -n gsm.sim.operator.numeric "$MCCMNC,$MCCMNC"
/data/adb/ap/bin/resetprop -n ril.mcc.mnc0 "$MCCMNC,$MCCMNC"
/data/adb/ap/bin/resetprop -n ril.mcc.mnc1 "$MCCMNC,$MCCMNC"
/data/adb/ap/bin/resetprop -n debug.tracing.mcc "$MCC"
/data/adb/ap/bin/resetprop -n debug.tracing.mnc "$MNC"
/data/adb/ap/bin/resetprop -n gsm.operator.alpha "$OPERATOR,$OPERATOR"
/data/adb/ap/bin/resetprop -n gsm.sim.operator.alpha "$OPERATOR,$OPERATOR"
/data/adb/ap/bin/resetprop -n persist.sys.timezone "$TZ"
/data/adb/ap/bin/resetprop -n gsm.operator.isroaming "false,false"
/data/adb/ap/bin/resetprop -n sys.wifitracing.started "0"
/data/adb/ap/bin/resetprop -n persist.vendor.wifienhancelog "0"
/data/adb/ap/bin/resetprop -n persist.vendor.radio.imei  "$IMEI1"
/data/adb/ap/bin/resetprop -n persist.vendor.radio.imei1 "$IMEI1"
/data/adb/ap/bin/resetprop -n persist.vendor.radio.imei2 "$IMEI2"
settings put global auto_time_zone 1
settings put global private_dns_mode off
settings put global development_settings_enabled 1
settings put global non_persistent_mac_randomization_force_enabled 1
settings put global restricted_networking_mode 0
settings put global bug_report 0
settings put global device_name Android
settings put secure tethering_allow_vpn_upstreams 1
settings put secure bluetooth_name Android
settings put secure android_id $NEW_ANDROID_ID

/data/adb/ap/bin/busybox sed -i "s#value=\"[a-zA-Z0-9]*\"#value=\"$NEW_ANDROID_ID\"#g" /data/system/users/0/settings_ssaid.xml
/data/adb/ap/bin/busybox sed -i -e 's#<string name="adid_key">.*</string>#<string name="adid_key">00000000-0000-0000-0000-000000000000</string>#' \
       -e 's#<int name="adid_reset_count" value=".*"/>#<int name="adid_reset_count" value="1"/>#' \
       /data/data/com.google.android.gms/shared_prefs/adid_settings.xml

EOF

/data/adb/ap/bin/busybox echo ""
/data/adb/ap/bin/busybox echo "[+] Creating SIM-Service.sh..."
/data/adb/ap/bin/busybox cat > /data/adb/service.d/SIM-Service.sh <<EOF
#!/data/adb/ap/bin/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

while true; do
    /data/adb/ap/bin/busybox sh /data/adb/service.d/SIM-Spoof.sh
    sleep 5
done
EOF

/data/adb/ap/bin/busybox echo "[+] Creating SIM-TTL.sh..."
/data/adb/ap/bin/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/ap/bin/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

BBR_ALGORITHM="$BBR_ALGORITHM"
DNS="$DNS"
DNSv6="$DNSv6"

if [ -n "$BBR_ALGORITHM" ]; then
    /data/adb/ap/bin/busybox echo $BBR_ALGORITHM > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
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

/data/adb/ap/bin/resetprop -n net.eth0.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.eth0.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.ppp0.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.ppp0.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet0.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet0.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet1.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet1.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet2.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet2.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet3.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.rmnet3.dns2 \$DNS
/data/adb/ap/bin/resetprop -n net.pdpbr1.dns1 \$DNS
/data/adb/ap/bin/resetprop -n net.pdpbr1.dns2 \$DNS
/data/adb/ap/bin/resetprop -n wlan0.dns1 \$DNS
/data/adb/ap/bin/resetprop -n wlan0.dns2 \$DNS
/data/adb/ap/bin/resetprop -n wlan1.dns1 \$DNS
/data/adb/ap/bin/resetprop -n wlan1.dns2 \$DNS
/data/adb/ap/bin/resetprop -n wlan2.dns1 \$DNS
/data/adb/ap/bin/resetprop -n wlan2.dns2 \$DNS
/data/adb/ap/bin/resetprop -n wlan3.dns1 \$DNS
/data/adb/ap/bin/resetprop -n wlan3.dns2 \$DNS
EOF

/data/adb/ap/bin/busybox chmod +x /data/adb/service.d/SIM-*.sh

/data/adb/ap/bin/busybox echo ""
/data/adb/ap/bin/busybox echo "=========================================="
/data/adb/ap/bin/busybox echo "   [✓] Scripts successfully installed!    "
/data/adb/ap/bin/busybox echo "=========================================="

/data/adb/ap/bin/busybox echo "Location: /data/adb/service.d/SIM-*.sh"
/data/adb/ap/bin/busybox echo ""
/data/adb/ap/bin/busybox echo "GitHub: https://github.com/UhExooHw/sim-spoof"

while true; do
    /data/adb/ap/bin/busybox echo ""
    /data/adb/ap/bin/busybox echo "Reboot required to apply changes."
    /data/adb/ap/bin/busybox echo "  [1] Reboot now"
    /data/adb/ap/bin/busybox echo "  [2] Reboot later"
    /data/adb/ap/bin/busybox echo -n "Choose an option (1-2): "
    read REBOOT_CHOICE
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) /data/adb/ap/bin/busybox echo "You can reboot manually later."; break ;;
        *) /data/adb/ap/bin/busybox echo "[!] Invalid choice. Try again." ;;
    esac
done
