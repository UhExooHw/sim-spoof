#!/data/adb/ksu/bin/busybox sh

LOG="/data/local/tmp/script.log"
exec >> "$LOG" 2>&1
set -e
trap 'echo "[×] Error at line $LINENO. Continuing..."' ERR

/data/adb/ksu/bin/busybox clear
/data/adb/ksu/bin/busybox echo "========================================="
/data/adb/ksu/bin/busybox echo "         SIM Spoof Utility          "
/data/adb/ksu/bin/busybox echo "========================================="

/data/adb/ksu/bin/busybox echo "[•] Checking environment..."
/data/adb/ksu/bin/busybox test ! -d /data/adb/service.d && /data/adb/ksu/bin/busybox echo "[×] Root solution not installed." && exit 1

BBR_SUPPORTED=false
/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && BBR_SUPPORTED=true
if [ "$BBR_SUPPORTED" = true ]; then
    /data/adb/ksu/bin/busybox echo "[✓] BBR supported."
else
    /data/adb/ksu/bin/busybox echo "[!] BBR not supported."
fi

/data/adb/ksu/bin/busybox which iptables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "[×] iptables not found."; exit 1; }
/data/adb/ksu/bin/busybox which ip6tables >/dev/null 2>&1 || { /data/adb/ksu/bin/busybox echo "[×] ip6tables not found."; exit 1; }

/data/adb/ksu/bin/busybox echo "[✓] Environment OK."

while true; do
    /data/adb/ksu/bin/busybox echo "Select Mobile Operator:"
    /data/adb/ksu/bin/busybox echo "  [1] Beeline  [2] MTS  [3] Tele2  [4] Megafon  [5] Yota  [6] A1  [7] life:)"
    /data/adb/ksu/bin/busybox echo "  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom  [12] KPN  [13] Custom  [0] Exit"
    /data/adb/ksu/bin/busybox echo -n "Enter number (0-13): "
    read OPERATOR_CHOICE || continue
    case "$OPERATOR_CHOICE" in
        0) /data/adb/ksu/bin/busybox echo "Exiting..."; exit 0 ;;
        1)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country: [1] Uzbekistan [2] Kazakhstan [3] Russia [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-3): "
                read COUNTRY_CHOICE || continue
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="43404" ISO="uz" TZ="Asia/Tashkent" OPERATOR="Beeline"; break 2 ;;
                    2) MCCMNC="40101" ISO="kz" TZ="Asia/Almaty" OPERATOR="Beeline"; break 2 ;;
                    3) MCCMNC="25099" ISO="ru" TZ="Europe/Moscow" OPERATOR="Beeline"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
                esac
            done ;;
        2)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country: [1] Belarus [2] Russia [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-2): "
                read COUNTRY_CHOICE || continue
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25702" ISO="by" TZ="Europe/Minsk" OPERATOR="MTS"; break 2 ;;
                    2) MCCMNC="25001" ISO="ru" TZ="Europe/Moscow" OPERATOR="MTS"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
                esac
            done ;;
        3)
            while true; do
                /data/adb/ksu/bin/busybox echo "Select Country: [1] Russia [2] Latvia [3] Sweden [4] Estonia [0] Back"
                /data/adb/ksu/bin/busybox echo -n "Enter number (0-4): "
                read COUNTRY_CHOICE || continue
                case "$COUNTRY_CHOICE" in
                    0) break ;;
                    1) MCCMNC="25020" ISO="ru" TZ="Europe/Moscow" OPERATOR="t2"; break 2 ;;
                    2) MCCMNC="24702" ISO="lv" TZ="Europe/Riga" OPERATOR="Tele2"; break 2 ;;
                    3) MCCMNC="24007" ISO="se" TZ="Europe/Stockholm" OPERATOR="Tele2"; break 2 ;;
                    4) MCCMNC="24803" ISO="ee" TZ="Europe/Tallinn" OPERATOR="Tele2"; break 2 ;;
                    *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
                esac
            done ;;
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
            /data/adb/ksu/bin/busybox echo "Manual Custom Input:"
            /data/adb/ksu/bin/busybox echo -n "MCCMNC: "; read MCCMNC || continue
            /data/adb/ksu/bin/busybox echo -n "ISO: "; read ISO || continue
            /data/adb/ksu/bin/busybox echo -n "TimeZone: "; read TZ || continue
            /data/adb/ksu/bin/busybox echo -n "Operator: "; read OPERATOR || continue
            break ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
    esac
done

while true; do
    /data/adb/ksu/bin/busybox echo "Choose DNS Provider: [1] Cloudflare [2] Google [3] Quad9 [4] Custom [0] Back"
    /data/adb/ksu/bin/busybox echo -n "Enter number (0-4): "
    read DNS_CHOICE || continue
    case "$DNS_CHOICE" in
        0) exec "$0" ;;
        1) DNS="1.1.1.1"; DNSv6="2606:4700:4700::1111"; break ;;
        2) DNS="8.8.8.8"; DNSv6="2001:4860:4860::8888"; break ;;
        3) DNS="9.9.9.9"; DNSv6="2620:fe::fe"; break ;;
        4)
            /data/adb/ksu/bin/busybox echo -n "DNS IPv4: "; read DNS || continue
            /data/adb/ksu/bin/busybox echo -n "DNS IPv6: "; read DNSv6 || continue
            break ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid option." ;;
    esac
done

/data/adb/ksu/bin/busybox echo "[+] Creating SIM-Spoof.sh..."
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-Spoof.sh <<EOF
#!/data/adb/ksu/bin/busybox sh
LOG="/data/local/tmp/script1.log"
exec >> "\$LOG" 2>&1
trap 'echo "[×] Error at line \$LINENO. Continuing..."' ERR
while true; do
    /data/adb/ksu/bin/resetprop -n gsm.operator.iso-country ${ISO} || true
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.iso-country ${ISO} || true
    /data/adb/ksu/bin/resetprop -n gsm.operator.numeric ${MCCMNC} || true
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.numeric ${MCCMNC} || true
    /data/adb/ksu/bin/resetprop -n gsm.operator.alpha "${OPERATOR}" || true
    /data/adb/ksu/bin/resetprop -n gsm.sim.operator.alpha "${OPERATOR}" || true
    /data/adb/ksu/bin/resetprop -n persist.sys.timezone ${TZ} || true
    settings put global auto_time_zone 1 || true
    settings put global private_dns_mode off || true
    /data/adb/ksu/bin/busybox sleep 5
done
EOF

/data/adb/ksu/bin/busybox echo "[+] Creating SIM-TTL.sh..."
/data/adb/ksu/bin/busybox cat > /data/adb/service.d/SIM-TTL.sh <<EOF
#!/data/adb/ksu/bin/busybox sh
LOG="/data/local/tmp/script1.log"
exec >> "\$LOG" 2>&1
trap 'echo "[×] Error at line \$LINENO. Continuing..."' ERR

DNS="${DNS}"
DNSv6="${DNSv6}"

/data/adb/ksu/bin/busybox grep -Eqw 'bbr|bbr2' /proc/sys/net/ipv4/tcp_available_congestion_control && {
    /data/adb/ksu/bin/busybox grep -qw bbr2 /proc/sys/net/ipv4/tcp_available_congestion_control && \
        /data/adb/ksu/bin/busybox echo bbr2 > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null || \
        /data/adb/ksu/bin/busybox echo bbr > /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null
}

while iptables -t nat -D OUTPUT -p tcp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t nat -D OUTPUT -p udp --dport 53 -j DNAT 2>/dev/null; do :; done
while iptables -t mangle -D POSTROUTING -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D POSTROUTING -j HL --hl-set 64 2>/dev/null; do :; done
while iptables -t mangle -D OUTPUT -j TTL --ttl-set 64 2>/dev/null; do :; done
while ip6tables -t mangle -D OUTPUT -j HL --hl-set 64 2>/dev/null; do :; done

iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64 || true
ip6tables -t mangle -A POSTROUTING -j HL --hl-set 64 || true
iptables -t mangle -A OUTPUT -j TTL --ttl-set 64 || true
ip6tables -t mangle -A OUTPUT -j HL --hl-set 64 || true

iptables -t nat -C OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination ${DNS}:53
iptables -t nat -C OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53 2>/dev/null || iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination ${DNS}:53

for iface in eth0 ppp0 rmnet0 rmnet1 rmnet2 rmnet3 pdpbr1 wlan0 wlan1 wlan2 wlan3; do
    /data/adb/ksu/bin/resetprop -n net.\$iface.dns1 ${DNS} || true
    /data/adb/ksu/bin/resetprop -n net.\$iface.dns2 ${DNS} || true
done
EOF

/data/adb/ksu/bin/busybox chmod +x /data/adb/service.d/SIM-*.sh

/data/adb/ksu/bin/busybox echo "=========================================="
/data/adb/ksu/bin/busybox echo "   [✓] Scripts successfully installed!    "
/data/adb/ksu/bin/busybox echo "=========================================="
/data/adb/ksu/bin/busybox echo "Location: /data/adb/service.d/SIM-*.sh"
/data/adb/ksu/bin/busybox echo "GitHub: https://github.com/UhExooHw/sim-spoof"

while true; do
    /data/adb/ksu/bin/busybox echo "Reboot required to apply changes. [1] Reboot now [2] Reboot later"
    /data/adb/ksu/bin/busybox echo -n "Choose an option (1-2): "
    read REBOOT_CHOICE || continue
    case "$REBOOT_CHOICE" in
        1) reboot; break ;;
        2) /data/adb/ksu/bin/busybox echo "You can reboot manually later."; break ;;
        *) /data/adb/ksu/bin/busybox echo "[!] Invalid choice. Try again." ;;
    esac
done
