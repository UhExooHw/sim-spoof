# 🚀 SIM Spoof

* ⚠️ **Warning:** May violate laws or carrier rules. Use at **your own risk**.
* ⚠️ Supports **devices with only 1 SIM card in the SIM1 slot**.

---

## ⚙️ Requirements

* KernelSU / Magisk (experimental)
* Android 12+
* `iptables` & `ip6tables`

---

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 🔐 Intercept DNS
* 🚀 Enable TCP BBR
* 📶 Hide tethering
* 📶 Hide roaming
* ⚠️ Bypass geoblocks (e.g., Google Play, TikTok, Deezer)

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
| Airtel   | IN         | 40402               |

---

## 📦 Installation

### SH / KSU

```bash
su
/data/adb/ksu/bin/busybox wget -O /data/local/tmp/ksu.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/ksu.sh
/data/adb/ksu/bin/busybox chmod +x /data/local/tmp/ksu.sh
/data/adb/ksu/bin/busybox sh /data/local/tmp/ksu.sh
```

### SH / Magisk

```bash
su
/data/adb/magisk/busybox wget -O /data/local/tmp/magisk.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/magisk.sh
/data/adb/magisk/busybox chmod +x /data/local/tmp/magisk.sh
/data/adb/magisk/busybox sh /data/local/tmp/magisk.sh
```

### ADB / KSU

```bash
adb root
adb shell /data/adb/ksu/bin/busybox wget -O /data/local/tmp/ksu.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/ksu.sh
adb shell /data/adb/ksu/bin/busybox chmod +x /data/local/tmp/ksu.sh
adb shell /data/adb/ksu/bin/busybox sh /data/local/tmp/ksu.sh
```

### ADB / Magisk

```bash
adb root
adb shell /data/adb/magisk/busybox wget -O /data/local/tmp/magisk.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/magisk.sh
adb shell /data/adb/magisk/busybox chmod +x /data/local/tmp/magisk.sh
adb shell /data/adb/magisk/busybox sh /data/local/tmp/magisk.sh
```

---

## TODO
* Magisk/KernelSU module
* More operators
* imei
* Android ID
* Advertisement ID
* Dual SIM support
* DNS over TLS support

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)

---
