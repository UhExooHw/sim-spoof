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
* iptables & ip6tables
* [Systemless Apns](https://github.com/UhExooHw/systemless-apns)

---

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 📶 Spoof imei (prop)
* 🔐 Spoof serialno
* 🔐 Spoof Advertising ID
* 🔐 Spoof Android ID
* 🔐 Intercept DNS
* 🔐 Systemless Busybox
* 🔐 Systemless Resetprop
* 🔐 [StevenBlack integration](https://github.com/StevenBlack/hosts)
* 🔐 [Xray integration](https://github.com/XTLS/Xray-core)
* 🔐 [Mihomo integration](https://github.com/MetaCubeX/mihomo)
* 🔐 [Sing-box integration](https://github.com/SagerNet/sing-box)
* 🚀 Enable TCP BBR
* 📶 Hide tethering
* 📶 Hide roaming
* 🌍 Bypass geoblocks (e.g., Google Play, TikTok, Deezer)

## 📦 Installation

### SH / KSU

```bash
su
/data/adb/ksu/bin/busybox wget -O /data/local/tmp/sim-spoof.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/sim-spoof.sh
/data/adb/ksu/bin/busybox chmod +x /data/local/tmp/sim-spoof.sh
/data/adb/ksu/bin/busybox sh /data/local/tmp/sim-spoof.sh
```

### ADB / KSU

```bash
adb root
adb shell /data/adb/ksu/bin/busybox wget -O /data/local/tmp/sim-spoof.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/sim-spoof.sh
adb shell /data/adb/ksu/bin/busybox chmod +x /data/local/tmp/sim-spoof.sh
adb shell /data/adb/ksu/bin/busybox sh /data/local/tmp/sim-spoof.sh
```

---

## TODO
* Dual SIM support

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)


---

## 📄 License
This project is licensed under the [Apache License 2.0](LICENSE).

---
