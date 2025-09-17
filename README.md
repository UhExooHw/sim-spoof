# 🚀 SIM Spoof

## ⚙️ Requirements

* KernelSU/Magisk/APatch
* Android 13+
* iptables & ip6tables
* arm64-v8a
* [Systemless Utils](https://github.com/UhExooHw/systemless-utils)

---

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 📶 Spoof imei (prop)
* 🔐 Spoof serialno
* 🔐 Spoof Advertising ID
* 🔐 Spoof Android ID
* 🔐 Intercept DNS
* 🔐 Systemless Busybox, Resetprop, bash
* 🔐 [StevenBlack integration](https://github.com/StevenBlack/hosts)
* 🔐 [Xray integration](https://github.com/XTLS/Xray-core)
* 🔐 [Mihomo integration](https://github.com/MetaCubeX/mihomo)
* 🔐 [Sing-box integration](https://github.com/SagerNet/sing-box)
* 🚀 Enable TCP BBR
* 📶 Hide tethering
* 📶 Hide roaming
* 🌍 Bypass geoblocks (e.g., Google Play, TikTok, Deezer)

## 📦 Installation

### Bash

```bash
su
busybox wget -O /data/local/tmp/sim-spoof.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/sim-spoof.sh
busybox chmod +x /data/local/tmp/sim-spoof.sh
bash /data/local/tmp/sim-spoof.sh
```

### ADB

```bash
adb root
adb shell
busybox wget -O /data/local/tmp/sim-spoof.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/data/local/tmp/sim-spoof.sh
busybox chmod +x /data/local/tmp/sim-spoof.sh
bash /data/local/tmp/sim-spoof.sh
```

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)

## 📄 TODO
* Spoof via API
* Create a module
* Bash script

## 📄 License
This project is licensed under the [Apache License 2.0](LICENSE).

---
