# 🚀 SIM Spoof

* ⚠️ **Warning:** May violate laws or carrier rules. Use at **your own risk**.
* ⚠️ Supports **SIM1 only**.

---

## ⚙️ Requirements

* KernelSU Next or KernelSU
* BusyBox
* Resetprop
* Android 12+
* `iptables` & `ip6tables`

---

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 🔐 Intercept DNS (IPv4/IPv6)
* 🚀 Enable TCP BBR
* 📶 Hide tethering
* ⚠️ Bypass geoblocks (e.g., Google Play, TikTok)

---

## 🌐 Supported Operators

| Operator | Country    | MCCMNC              |
| -------- | ---------- | ------------------- |
| Beeline  | UZ, KZ, RU | 43404, 40101, 25099 |
| MTS      | BY, RU     | 25702, 25001        |
| t2       | RU         | 25020               |
| Tele2    | LV, SE, EE | 24702, 24007, 24803 |
| Megafon  | RU         | 25002               |
| Yota     | RU         | 25011               |
| A1       | BY         | 25701               |
| life:)   | BY         | 25704               |
| Salt     | CH         | 22803               |
| Turkcell | TR         | 28601               |
| Telia    | FI         | 24491               |
| Telekom  | DE         | 26201               |
| KPN      | NL         | 20408               |

---

## 📦 Installation

### SH

```bash
su
/data/adb/ksu/bin/busybox wget -O /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/script.sh
/data/adb/ksu/bin/busybox chmod +x /data/local/tmp/script.sh
/data/adb/ksu/bin/busybox sh /data/local/tmp/script.sh
```

### ADB

```bash
adb root
adb shell /data/adb/ksu/bin/busybox wget -O /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/script.sh
adb shell /data/adb/ksu/bin/busybox chmod +x /data/local/tmp/script.sh
adb shell /data/adb/ksu/bin/busybox sh /data/local/tmp/script.sh
```

---

## 🖥 Example

```
╔════════════════════════╗
║  ReBullet SIM Spoof    ║
╚════════════════════════╝

[✓] Environment OK
Select Mobile Operator: 13
Manual Custom Input:
MCCMNC: 25099
ISO: ru
TimeZone: Europe/Moscow
Operator: Beeline
Choose DNS: 4
DNS IPv4: 1.1.1.1
DNS IPv6: 2606:4700:4700::1111
[✓] Scripts installed. Boot load enabled.
Reboot required: 1) Now 2) Later
```

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)

---
