# 🚀 SIM Spoof

* ⚠️ **Warning:** May violate laws or carrier rules. Use at **your own risk**.
* ⚠️ Supports **devices with only 1 SIM card in the SIM1 slot**.

Вот английская версия обновлённого раздела **Requirements**:

---

## ⚙️ Requirements

* KernelSU / Magisk (experimental)
* Android 12+
* `iptables` & `ip6tables`
* [systemless hosts KernelSU module](https://github.com/symbuzzer/systemless-hosts-KernelSU-module)

---

Если хочешь, могу сразу вставить это в твой полный README на английском.


Если хочешь, могу сразу вставить это в твой исходный README с сохранением всех остальных секций.

## 💡 Features

* 🌍 Spoof SIM: MCCMNC, ISO, operator
* 🕓 Spoof time zone
* 📶 Spoof imei (prop)
* 🔐 Spoof Advertising ID
* 🔐 Spoof Android ID
* 🔐 Intercept DNS
* 🔐 Adblock
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
* Dual SIM support

---

## 👤 Author

GitHub: [UhExooHw](https://github.com/UhExooHw)


---

## 📄 License
This project is licensed under the [Apache License 2.0](LICENSE).

---
