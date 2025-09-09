#!/data/adb/magisk/busybox sh

/data/adb/magisk/busybox clear

/data/adb/magisk/busybox echo "========================================="
/data/adb/magisk/busybox echo "         SIM Spoof Utility          "
/data/adb/magisk/busybox echo "========================================="

/data/adb/magisk/busybox echo "[•] Checking environment..."

/data/adb/magisk/busybox test ! -d /data/adb/service.d && /data/adb/magisk/busybox echo "[×] Root solution KernelSU not installed. Exiting." && exit 1

BBR_SUPPORTED=false
/data/adb/magisk/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_SUPPORTED=true
if [ "$BBR_SUPPORTED" = true ]; then
    /data/adb/magisk/busybox echo "[✓] BBR supported."
else
    /data/adb/magisk/busybox echo "[!] BBR not supported. Skipping."
fi

/data/adb/magisk/busybox which iptables >/dev/null 2>&1 || { /data/adb/magisk/busybox echo "[×] iptables not found. Exiting."; exit 1; }
/data/adb/magisk/busybox which ip6tables >/dev/null 2>&1 || { /data/adb/magisk/busybox echo "[×] ip6tables not found. Exiting."; exit 1; }
/data/adb/magisk/busybox echo "[✓] Environment OK."

while true; do
    /data/adb/magisk/busybox echo "Select Mobile Operator:"
    /data/adb/magisk/busybox echo "  [1] Beeline  [2] MTS  [3] Tele2"
    /data/adb/magisk/busybox echo "  [4] Megafon  [5] Yota  [6] A1  [7] life:)"
    /data/adb/magisk/busybox echo "  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom"
    /data/adb/magisk/busybox echo "  [12] KPN  [13] Airtel"
    /data/adb/magisk/busybox echo "  [14] Custom  [0] Exit"
    /data/adb/magisk/busybox echo -n "Enter number (0-14): "
    read OPERATOR_CHOICE
    case "$OPERATOR_CHOICE" in
        0) /data/adb/magisk/busybox echo "Exiting..."; exit 0 ;;
        1)
            while true; do
                /data/adb/magisk/busybox echo "Select Country:"
                /data/adb/magisk/busybox echo "  [1] Uzbekistan  [2] Kazakhstan  [3] Russia  [0] Back"
                /data/adb/magisk/busybox echo -n "Enter number (0-3): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" MCC="434" MNC="04" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" MCC="401" MNC="01" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" MCC="250" MNC="99" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) /data/adb/magisk/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        2)
            while true; do
                /data/adb/magisk/busybox echo "Select Country:"
                /data/adb/magisk/busybox echo "  [1] Belarus  [2] Russia  [0] Back"
                /data/adb/magisk/busybox echo -n "Enter number (0-2): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" MCC="257" MNC="02" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" MCC="250" MNC="01" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) /data/adb/magisk/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        3)
            while true; do
                /data/adb/magisk/busybox echo "Select Country:"
                /data/adb/magisk/busybox echo "  [1] Russia  [2] Latvia  [3] Sweden  [4] Estonia  [0] Back"
                /data/adb/magisk/busybox echo -n "Enter number (0-4): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" MCC="250" MNC="20" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
                    2) MCCMNC="24702" MCC="247" MNC="02" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" MCC="240" MNC="07" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" MCC="248" MNC="03" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) /data/adb/magisk/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        4) MCCMNC="25002" MCC="250" MNC="02" ISO="ru" TZ="Europe/Moscow" OPERATOR="Megafon"; break ;;
        5) MCCMNC="25011" MCC="250" MNC="11" ISO="ru" TZ="Europe/Moscow" OPERATOR="Yota"; break ;;
        6) MCCMNC="25701" MCC="257" MNC="01" ISO="by" TZ="Europe/Minsk" OPERATOR="A1"; break ;;
        7) MCCMNC="25704" MCC="257" MNC="04" ISO="by" TZ="Europe/Minsk" OPERATOR="life:)"; break ;;
        8) MCCMNC="22803" MCC="228" MNC="03" ISO="ch" TZ="Europe/Zurich" OPERATOR="Salt"; break ;;
        9) MCCMNC="28601" MCC="286" MNC="01" ISO="tr" TZ="Europe/Istanbul" OPERATOR="Turkcell"; break ;;
        10) MCCMNC="24491" MCC="244" MNC="91" ISO="fi" TZ="Europe/Helsinki" OPERATOR="Telia"; break ;;
        11) MCCMNC="26201" MCC="262" MNC="01" ISO="de" TZ="Europe/Berlin" OPERATOR="Telekom"; break ;;
        12) MCCMNC="20408" MCC="204" MNC="08" ISO="nl" TZ="Europe/Amsterdam" OPERATOR="KPN"; break ;;
        13) MCCMNC="40402" MCC="404" MNC="02" ISO="in" TZ="Asia/Kolkata" OPERATOR="Airtel"; break ;;
        14)
            /data/adb/magisk/busybox echo "Manual Custom Input:"
            /data/adb/magisk/busybox echo -n "MCCMNC: "; read MCCMNC
            /data/adb/magisk/busybox echo -n "MCC: "; read MCC
            /data/adb/magisk/busybox echo -n "MNC: "; read MNC
            /data/adb/magisk/busybox echo -n "ISO: "; read ISO
            /data/adb/magisk/busybox echo -n "TimeZone: "; read TZ
            /data/adb/magisk/busybox echo -n "Operator: "; read OPERATOR
            break
            ;;
        *) /data/adb/magisk/busybox echo "[!] Invalid option." ;;
    esac
done

while true; do
    /data/adb/magisk/busybox echo "Choose DNS Provider:"
    /data/adb/magisk/busybox echo "  [1] Cloudflare  [2] Google  [3] Quad9  [4] Custom  [0] Back"
    /data/adb/magisk/busybox echo -n "Enter number (0-4): "
    read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4)
            /data/adb/magisk/busybox echo -n "DNS IPv4: "; read DNS
            /data/adb/magisk/busybox echo -n "DNS IPv6: "; read DNSv6
            break
            ;;
        *) /data/adb/magisk/busybox echo "[!] Invalid option." ;;
    esac
done

/data/adb/magisk/busybox echo ""
/data/adb/magisk/busybox echo "[+] Creating SIM-Spoof.sh..."
/data/adb/magisk/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/data/adb/magisk/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

/product/bin/resetprop -n gsm.operator.iso-country "$ISO,$ISO"
/product/bin/resetprop -n gsm.sim.operator.iso-country "$ISO,$ISO"
/product/bin/resetprop -n gsm.operator.numeric "$MCCMNC,$MCCMNC"
/product/bin/resetprop -n gsm.sim.operator.numeric "$MCCMNC,$MCCMNC"
/product/bin/resetprop -n ril.mcc.mnc0 "$MCCMNC,$MCCMNC"
/product/bin/resetprop -n ril.mcc.mnc1 "$MCCMNC,$MCCMNC"
/product/bin/resetprop -n debug.tracing.mcc "$MCC"
/product/bin/resetprop -n debug.tracing.mnc "$MNC"
/product/bin/resetprop -n gsm.operator.alpha "$OPERATOR,$OPERATOR"
/product/bin/resetprop -n gsm.sim.operator.alpha "$OPERATOR,$OPERATOR"
/product/bin/resetprop -n persist.sys.timezone "$TZ"
/product/bin/resetprop -n gsm.operator.isroaming "false,false"
settings put global auto_time_zone 1
settings put global private_dns_mode off
EOF

/data/adb/magisk/busybox echo "[+] Creating SIM-TTL.sh..."
/data/adb/magisk/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/magisk/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

DNS="$DNS"
DNSv6="$DNSv6"

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
iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null || \
    iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination $DNS:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53 2>/dev/null || \
    iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination $DNS:53

/product/bin/resetprop -n net.eth0.dns1 $DNS
/product/bin/resetprop -n net.eth0.dns2 $DNS
/product/bin/resetprop -n net.dns1 $DNS
/product/bin/resetprop -n net.dns2 $DNS
/product/bin/resetprop -n net.ppp0.dns1 $DNS
/product/bin/resetprop -n net.ppp0.dns2 $DNS
/product/bin/resetprop -n net.rmnet0.dns1 $DNS
/product/bin/resetprop -n net.rmnet0.dns2 $DNS
/product/bin/resetprop -n net.rmnet1.dns1 $DNS
/product/bin/resetprop -n net.rmnet1.dns2 $DNS
/product/bin/resetprop -n net.rmnet2.dns1 $DNS
/product/bin/resetprop -n net.rmnet2.dns2 $DNS
/product/bin/resetprop -n net.rmnet3.dns1 $DNS
/product/bin/resetprop -n net.rmnet3.dns2 $DNS
/product/bin/resetprop -n net.pdpbr1.dns1 $DNS
/product/bin/resetprop -n net.pdpbr1.dns2 $DNS
/product/bin/resetprop -n wlan0.dns1 $DNS
/product/bin/resetprop -n wlan0.dns2 $DNS
/product/bin/resetprop -n wlan1.dns1 $DNS
/product/bin/resetprop -n wlan1.dns2 $DNS
/product/bin/resetprop -n wlan2.dns1 $DNS
/product/bin/resetprop -n wlan2.dns2 $DNS
/product/bin/resetprop -n wlan3.dns1 $DNS
/product/bin/resetprop -n wlan3.dns2 $DNS
EOF

/data/adb/magisk/busybox chmod +x /data/adb/service.d/SIM-*.sh

/data/adb/magisk/busybox echo ""
/data/adb/magisk/busybox echo "=========================================="
/data/adb/magisk/busybox echo "   [✓] Scripts successfully installed!    "
/data/adb/magisk/busybox echo "=========================================="

/data/adb/magisk/busybox echo "Location: /data/adb/service.d/SIM-*.sh"
/data/adb/magisk/busybox echo ""
/data/adb/magisk/busybox echo "GitHub: https://github.com/UhExooHw/sim-spoof"

while true; do
    /data/adb/magisk/busybox echo ""
    /data/adb/magisk/busybox echo "Reboot required to apply changes."
    /data/adb/magisk/busybox echo "  [1] Reboot now"
    /data/adb/magisk/busybox echo "  [2] Reboot later"
    /data/adb/magisk/busybox echo -n "Choose an option (1-2): "
    read REBOOT_CHOICE
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) /data/adb/magisk/busybox echo "You can reboot manually later."; break ;;
        *) /data/adb/magisk/busybox echo "[!] Invalid choice. Try again." ;;
    esac
done
