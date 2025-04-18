<p align="center">
  🇬🇧 <a href="README.md">English</a> &nbsp;|&nbsp;
  🇷🇺 <a href="README_RU.md">Русский</a> &nbsp;|&nbsp;
  🇨🇳 <a href="README_CN.md">简体中文</a> &nbsp;|&nbsp;
  🇮🇷 <a href="README_IR.md">فارسی</a>
</p>

# 🚀 ReBullet SIM Spoof Utility

> ⚠️ **警告：** 使用此脚本可能违反法律或运营商条款。请**自行承担风险**。  
> ⚠️ 仅支持 **SIM1**，不支持 SIM2。

---

## ⚙️ 要求

- Android 9+（API 28）
- Magisk 20.4+
- iptables
- ip6tables
- 支持 TCP BBR 的内核（可选）

---

## 💡 功能

- 🌍 伪装 SIM：MCCMNC、运营商 ISO
- 🕓 修改时区
- 🔐 拦截 DNS 和 DoT（DNS over TLS）（IPv4/IPv6）
- 🚀 启用 TCP BBR
- 📶 隐藏网络共享功能，防止被运营商识别
- ⚠️ 绕过基于 SIM 卡国家的地理封锁（如 Google Play、TikTok 等）

---

## 🌐 支持的运营商

| 运营商       | 国家           | MCCMNC |
|--------------|----------------|--------|
| Beeline      | 乌兹别克斯坦    | 43404  |
| Beeline      | 哈萨克斯坦      | 40101  |
| Beeline      | 俄罗斯          | 25099  |
| MTS          | 白俄罗斯        | 25702  |
| MTS          | 俄罗斯          | 25001  |
| t2           | 俄罗斯          | 25020  |
| Tele2        | 拉脱维亚        | 24702  |
| Tele2        | 瑞典            | 24007  |
| Tele2        | 爱沙尼亚        | 24803  |
| Megafon      | 俄罗斯          | 25002  |
| Yota         | 俄罗斯          | 25011  |
| A1           | 白俄罗斯        | 25701  |
| life:)       | 白俄罗斯        | 25704  |
| Salt         | 瑞士            | 22803  |
| Turkcell     | 土耳其          | 28601  |
| Telia        | 芬兰            | 24491  |
| Telekom      | 德国            | 26201  |
| KPN          | 荷兰            | 20408  |

---

## 📦 安装

```bash
rm -f /data/local/tmp/script.sh && \
curl -fsSL -o /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/refs/heads/main/data/local/tmp/script.sh && \
chmod +x /data/local/tmp/script.sh && \
sh /data/local/tmp/script.sh
```

---

## 🖥 示例输出

```
╔════════════════════════════════════════╗
║        ReBullet SIM Spoof Utility      ║
╚════════════════════════════════════════╝

[•] Checking environment...
[✓] BBR is supported by the kernel.
[✓] Environment OK.

Select Mobile Operator:
  [1] Beeline
  [2] MTS
  [3] Tele2 (T2)
  [4] Megafon (Russia)
  [5] Yota (Russia)
  [6] A1 (Belarus)
  [7] life:) (Belarus)
  [8] Salt (Switzerland)
  [9] Turkcell (Turkey)
  [10] Telia (Finland)
  [11] Telekom (Germany)
  [12] KPN (Netherlands)
  [13] Custom (manual input)
  [0] Exit
Enter number (0-13): 13

Manual Custom Input:
MCCMNC: 25099
ISO (e.g. ru): ru
TimeZone (e.g. Europe/Moscow): Europe/Moscow
Operator Name: Beeline

Choose DNS Provider:
  [1] Cloudflare (one.one.one.one)
  [2] Google     (dns.google)
  [3] Quad9      (dns.quad9.net)
  [4] Switch      (dns.switch.ch)
  [5] Custom DNS
  [0] Back
Enter number (0-5): 5

Enter DNS Ipv4: 1.1.1.1
Enter DNS Ipv6: 2606:4700:4700::1111
Enter DoT hostname: one.one.one.one

[+] Creating ReBullet-SIM.sh...
[+] Creating ReBullet-TTL.sh...

╔══════════════════════════════════════════╗
║   [✓] Scripts successfully installed!    ║
║   Loaded on boot via Magisk service.d    ║
╚══════════════════════════════════════════╝

Location: /data/adb/service.d/ReBullet-*.sh

GitHub: https://github.com/UhExooHw/sim-spoof

Reboot required to apply changes.
  [1] Reboot now
  [2] Reboot later
Choose an option (1-2): 2
You can reboot manually later.
```

---

## 👤 作者

GitHub: [UhExooHw](https://github.com/UhExooHw)

---
