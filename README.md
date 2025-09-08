# 🚀 SIM Spoof

> ⚠️ **Warning:** Using this script may violate laws or carrier terms. Use at your **own risk**.  
> ⚠️ Supports **SIM1 only**. SIM2 is not supported.

---

## ⚙️ Requirements

- KernelSU Next or KernelSU
- `iptables` and `ip6tables`

---

## 💡 Features

- 🌍 Spoof SIM: MCCMNC, operator ISO
- 🕓 Spoof time zone
- 🔐 Intercept DNS (IPv4/IPv6)
- 🚀 Activate TCP BBR
- 📶 Hide tethering from carrier
- ⚠️ Bypass geoblocks (e.g., Google Play, TikTok)

---

## 🌐 Supported Operators

| Operator     | Country        | MCCMNC |
|--------------|----------------|--------|
| Beeline      | Uzbekistan     | 43404  |
| Beeline      | Kazakhstan     | 40101  |
| Beeline      | Russia         | 25099  |
| MTS          | Belarus        | 25702  |
| MTS          | Russia         | 25001  |
| t2           | Russia         | 25020  |
| Tele2        | Latvia         | 24702  |
| Tele2        | Sweden         | 24007  |
| Tele2        | Estonia        | 24803  |
| Megafon      | Russia         | 25002  |
| Yota         | Russia         | 25011  |
| A1           | Belarus        | 25701  |
| life:)       | Belarus        | 25704  |
| Salt         | Switzerland    | 22803  |
| Turkcell     | Turkey         | 28601  |
| Telia        | Finland        | 24491  |
| Telekom      | Germany        | 26201  |
| KPN          | Netherlands    | 20408  |

---

## 📦 Installation

### Via Terminal

```bash
su
curl -fsSL -o /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/script.sh && chmod +x /data/local/tmp/script.sh && sh /data/local/tmp/script.sh
```

### Via ADB

```bash
.\adb root
.\adb shell /data/adb/ksu/bin/busybox wget -O /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/script.sh && .\adb shell chmod +x /data/local/tmp/script.sh && .\adb shell sh /data/local/tmp/script.sh
```

---

## 🖥 Example Output

```
╔════════════════════════════════════════╗
║        ReBullet SIM Spoof Utility      ║
╚════════════════════════════════════════╝

[•] Checking environment...
[✓] BBR supported.
[✓] Environment OK.

Select Mobile Operator:
  [1] Beeline  [2] MTS  [3] Tele2
  [4] Megafon  [5] Yota  [6] A1  [7] life:)
  [8] Salt  [9] Turkcell  [10] Telia  [11] Telekom
  [12] KPN  [13] Custom  [0] Exit
Enter number (0-13): 13

Manual Custom Input:
MCCMNC: 25099
ISO: ru
TimeZone: Europe/Moscow
Operator: Beeline

Choose DNS Provider:
  [1] Cloudflare  [2] Google  [3] Quad9  [4] Custom  [0] Back
Enter number (0-4): 4

DNS IPv4: 1.1.1.1
DNS IPv6: 2606:4700:4700::1111

[+] Creating ReBullet-SIM.sh...
[+] Creating ReBullet-TTL.sh...

╔══════════════════════════════════════════╗
║   [✓] Scripts installed! Loaded on boot  ║
╚══════════════════════════════════════════╝

Location: /data/adb/service.d/ReBullet-*.sh
GitHub: https://github.com/UhExooHw/sim-spoof

Reboot required.
  [1] Reboot now  [2] Later
Choose (1-2): 2
Reboot manually later.
```

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)
