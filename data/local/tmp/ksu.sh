#!/data/adb/ksu/bin/busybox sh

/data/adb/ksu/bin/busybox clear

/data/adb/ksu/bin/busybox echo "========================================="
/data/adb/ksu/bin/busybox echo "         SIM Spoof Utility          "
/data/adb/ksu/bin/busybox echo "========================================="

/data/adb/ksu/bin/busybox echo "[•] Checking environment..."

/data/adb/ksu/bin/busybox test ! -d /data/adb/service.d && /data/adb/ksu/bin/busybox echo "[×] Root solution KernelSU not installed. Exiting." && exit 1

BBR_SUPPORTED=false
/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_SUPPORTED=true
if [ "$BBR_SUPPORTED" = true ]; then
    /data/adb/ksu/bin/busybox echo "[✓] BBR supported."
else
    /data/adb/ksu/bin/busybox echo "[!] BBR not supported. Skipping."
fi

/data/adb/ksu/bin/busybox which iptables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "[×] iptables not found. Exiting."; exit 1; }
/data/adb/ksu/bin/busybox which ip6tables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "[×] ip6tables not found. Exiting."; exit 1; }
/data/adb/ksu/bin/busybox echo "[✓] Environment OK."

while true; do
    /data/adb/ksu/bin/busybox echo "Select Mobile Operator:"
    /data/adb/ksu/bin/busybox echo "  [1] Beeline  [2] MTS  [3] Tele2"
    /data/adb/ksu/bin/busybox echo "  [4] Megafon  [5] Yota  [6] A1  [7] life:)"
    /data/adb/ksu/bin/busybox echo "  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom"
    /data/adb/ksu/bin/busybox echo "  [12] KPN  [13] Airtel"
    /data/adb/ksu/bin/busybox echo "  [14] Custom  [0] Exit"
    /data/adb/ksu/bin/busybox echo -n "Enter number (0-14): "
    read OPERATOR_CHOICE
    case "$OPERATOR_CHOICE" in
        0) /data/adb/ksu/bin/busybox echo "Exiting..."; exit 0 ;;
        1)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country:"
                /data/adb/ksu/bin/busybox echo "  [1] Uzbekistan  [2] Kazakhstan  [3] Russia  [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-3): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" MCC="434" MNC="04" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" MCC="401" MNC="01" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" MCC="250" MNC="99" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        2)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country:"
                /data/adb/ksu/bin/busybox echo "  [1] Belarus  [2] Russia  [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-2): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" MCC="257" MNC="02" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" MCC="250" MNC="01" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
                esac
            done
            ;;
        3)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country:"
                /data/adb/ksu/bin/busybox echo "  [1] Russia  [2] Latvia  [3] Sweden  [4] Estonia  [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-4): "
                read COUNTRY_CHOICE
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" MCC="250" MNC="20" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
                    2) MCCMNC="24702" MCC="247" MNC="02" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" MCC="240" MNC="07" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" MCC="248" MNC="03" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
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
            /data/adb/ksu/bin/busybox echo "Manual Custom Input:"
            /data/adb/ksu/bin/busybox echo -n "MCCMNC: "; read MCCMNC
            /data/adb/ksu/bin/busybox echo -n "MCC: "; read MCC
            /data/adb/ksu/bin/busybox echo -n "MNC: "; read MNC
            /data/adb/ksu/bin/busybox echo -n "ISO: "; read ISO
            /data/adb/ksu/bin/busybox echo -n "TimeZone: "; read TZ
            /data/adb/ksu/bin/busybox echo -n "Operator: "; read OPERATOR
            break
            ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
    esac
done

while true; do
    /data/adb/ksu/bin/busybox echo "Choose DNS Provider:"
    /data/adb/ksu/bin/busybox echo "  [1] Cloudflare  [2] Google  [3] Quad9  [4] Custom  [0] Back"
    /data/adb/ksu/bin/busybox echo -n "Enter number (0-4): "
    read DNS_CHOICE
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4)
            /data/adb/ksu/bin/busybox echo -n "DNS IPv4: "; read DNS
            /data/adb/ksu/bin/busybox echo -n "DNS IPv6: "; read DNSv6
            break
            ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
    esac
done

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "[+] Creating SIM-Spoof.sh..."
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/data/adb/ksu/bin/busybox sh

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

setprop_if_diff() {
    local prop=$1
    local value=$2
    current=$(/data/adb/ksu/bin/getprop "$prop")
    if [ "$current" != "$value" ]; then
        /data/adb/ksu/bin/resetprop -n "$prop" "$value"
    fi
}

setprop_if_diff "gsm.operator.iso-country" "$ISO,$ISO"
setprop_if_diff "gsm.sim.operator.iso-country" "$ISO,$ISO"
setprop_if_diff "gsm.operator.numeric" "$MCCMNC,$MCCMNC"
setprop_if_diff "gsm.sim.operator.numeric" "$MCCMNC,$MCCMNC"
setprop_if_diff "ril.mcc.mnc0" "$MCCMNC,$MCCMNC"
setprop_if_diff "ril.mcc.mnc1" "$MCCMNC,$MCCMNC"
setprop_if_diff "debug.tracing.mcc" "$MCC"
setprop_if_diff "debug.tracing.mnc" "$MNC"
setprop_if_diff "gsm.operator.alpha" "$OPERATOR,$OPERATOR"
setprop_if_diff "gsm.sim.operator.alpha" "$OPERATOR,$OPERATOR"
setprop_if_diff "persist.sys.timezone" "$TZ"
setprop_if_diff "gsm.operator.isroaming" "false,false"

set_setting_if_diff() {
    local ns=$1
    local key=$2
    local value=$3
    current=$(settings get "$ns" "$key")
    if [ "$current" != "$value" ]; then
        settings put "$ns" "$key" "$value"
    fi
}

set_setting_if_diff global auto_time_zone 1
set_setting_if_diff global private_dns_mode "off"
set_setting_if_diff global non_persistent_mac_randomization_force_enabled 1
set_setting_if_diff global restricted_networking_mode 0
set_setting_if_diff secure tethering_allow_vpn_upstreams 1
EOF

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "[+] Creating SIM-Service.sh..."
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-Service.sh <<EOF
#!/data/adb/ksu/bin/busybox sh
while [ "\$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

while true; do
    /data/adb/ksu/bin/busybox sh /data/adb/service.d/SIM-Spoof.sh
    sleep 10
done
EOF

/data/adb/ksu/bin/busybox echo "[+] Creating SIM-TTL.sh..."
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/ksu/bin/busybox sh
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

/data/adb/ksu/bin/resetprop -n net.eth0.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.eth0.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.ppp0.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.ppp0.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet0.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet1.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet2.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet2.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet3.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.rmnet3.dns2 $DNS
/data/adb/ksu/bin/resetprop -n net.pdpbr1.dns1 $DNS
/data/adb/ksu/bin/resetprop -n net.pdpbr1.dns2 $DNS
/data/adb/ksu/bin/resetprop -n wlan0.dns1 $DNS
/data/adb/ksu/bin/resetprop -n wlan0.dns2 $DNS
/data/adb/ksu/bin/resetprop -n wlan1.dns1 $DNS
/data/adb/ksu/bin/resetprop -n wlan1.dns2 $DNS
/data/adb/ksu/bin/resetprop -n wlan2.dns1 $DNS
/data/adb/ksu/bin/resetprop -n wlan2.dns2 $DNS
/data/adb/ksu/bin/resetprop -n wlan3.dns1 $DNS
/data/adb/ksu/bin/resetprop -n wlan3.dns2 $DNS
EOF

/data/adb/ksu/bin/busybox chmod +x /data/adb/service.d/SIM-*.sh

/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "=========================================="
/data/adb/ksu/bin/busybox echo "   [✓] Scripts successfully installed!    "
/data/adb/ksu/bin/busybox echo "=========================================="

/data/adb/ksu/bin/busybox echo "Location: /data/adb/service.d/SIM-*.sh"
/data/adb/ksu/bin/busybox echo ""
/data/adb/ksu/bin/busybox echo "GitHub: https://github.com/UhExooHw/sim-spoof"

while true; do
    /data/adb/ksu/bin/busybox echo ""
    /data/adb/ksu/bin/busybox echo "Reboot required to apply changes."
    /data/adb/ksu/bin/busybox echo "  [1] Reboot now"
    /data/adb/ksu/bin/busybox echo "  [2] Reboot later"
    /data/adb/ksu/bin/busybox echo -n "Choose an option (1-2): "
    read REBOOT_CHOICE
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) /data/adb/ksu/bin/busybox echo "You can reboot manually later."; break ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid choice. Try again." ;;
    esac
done
