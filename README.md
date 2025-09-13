# 🚀 SIM Spoof

## Disclaimer

* ⚠️ **For testing and research purposes only.**  
* This project is intended exclusively for use in controlled environments. Do **not** use it for activities that violate laws, carrier policies, or service terms.

### No warranty  
* The software is provided **"AS IS"**, without warranty of any kind, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement.

### Limitation of liability  
* To the fullest extent permitted by law, the author(s) and contributors shall not be liable for any direct, indirect, incidental, special, punitive, or consequential damages arising from the use of or inability to use this software.

### Legal compliance  
* Users are solely responsible for ensuring their use complies with applicable laws and service provider policies in their jurisdiction. If you are unsure about the legality, **do not use this software** and consult a lawyer.

**Note:** This project supports **devices with only 1 SIM card in the SIM1 slot** (see Requirements). The Apache License 2.0 governs distribution; the license does not exempt users from local legal obligations.

---

## ⚙️ Requirements

* KernelSU/Magisk/APatch
* Android 12+
* `iptables` & `ip6tables`
* [Systemless Hosts](https://github.com/gloeyisk/systemless-hosts)

---

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 📶 Spoof imei (prop)
* 🔐 Spoof serialno
* 🔐 Spoof Advertising ID
* 🔐 Spoof Android ID
* 🔐 Intercept DNS
* 🔐 [StevenBlack integration](https://github.com/StevenBlack/hosts)
* 🚀 Enable TCP BBR
* 📶 Hide tethering
* 📶 Hide roaming
* 🌍 Bypass geoblocks (e.g., Google Play, TikTok, Deezer)

---

## 🌐 Supported Operators

| Operator | Country    | MCCMNC              |
| -------- | ---------- | ------------------- |
| Beeline  | UZ, KZ, RU | 43404, 40101, 25099 |
| MTS      | BY, RU     | 25702, 25001        |
| Tele2 RU | RU         | 25020               |
| Tele2    | LV, SE, EE | 24702, 24007, 24803 |
| Megafon  | RU         | 25002               |
| Yota     | RU         | 25011               |
| Velcom   | BY         | 25701               |
| Life:)   | BY         | 25704               |
| Salt     | CH         | 22803               |
| Turkcell | TR         | 28601               |
| Tele Finland    | FI         | 24491               |
| Telekom  | DE         | 26201               |
| KPN      | NL         | 20408               |
| Airtel   | IN         | 40402               |
| Kyivstar  | UA         | 25503               |
| Test (Debug)     | AQ           | 00101               |
| Irancell      | IR         | 43235               |

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

### SH / APatch

```bash
su
/data/adb/ap/bin/busybox wget -O /data/local/tmp/apatch.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/apatch.sh
/data/adb/ap/bin/busybox chmod +x /data/local/tmp/apatch.sh
/data/adb/ap/bin/busybox sh /data/local/tmp/apatch.sh
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

### ADB / APatch

```bash
adb root
adb shell /data/adb/ap/bin/busybox wget -O /data/local/tmp/apatch.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/apatch.sh
adb shell /data/adb/ap/bin/busybox chmod +x /data/local/tmp/apatch.sh
adb shell /data/adb/ap/bin/busybox sh /data/local/tmp/apatch.sh
```

---

## TODO
* Magisk/KernelSU/APatch module
* Dual SIM support

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)


---

## 📄 License
This project is licensed under the [Apache License 2.0](LICENSE).

---
