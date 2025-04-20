<p align="center">
  🇬🇧 <a href="README.md">English</a> &nbsp;|&nbsp;
  🇷🇺 <a href="README_RU.md">Русский</a> &nbsp;|&nbsp;
  🇨🇳 <a href="README_CN.md">简体中文</a> &nbsp;|&nbsp;
  🇮🇷 <a href="README_IR.md">فارسی</a>
</p>

# 🚀 ReBullet SIM Spoof Utility

> ⚠️ **هشدار:** استفاده از این اسکریپت ممکن است قوانین یا شرایط اپراتور را نقض کند. استفاده از آن **با مسئولیت خودتان است**.  
> ⚠️ فقط با **SIM1** کار می‌کند. سیم‌کارت دوم (SIM2) پشتیبانی نمی‌شود.

---

## ⚙️ پیش‌نیازها

- اندروید ۹ یا بالاتر (API 28)
- Magisk نسخه 20.4 یا بالاتر
- iptables
- ip6tables
- هسته (کرنل) با پشتیبانی از TCP BBR (اختیاری)

---

## 💡 قابلیت‌ها

- 🌍 جعل SIM: مقادیر MCCMNC و کد کشور اپراتور (ISO)
- 🕓 تنظیم منطقه زمانی جعلی
- 🔐 رهگیری DNS 
- 🚀 فعال‌سازی TCP BBR برای بهبود سرعت شبکه
- 📶 پنهان‌سازی اشتراک‌گذاری اینترنت (تترینگ) از دید اپراتور
- ⚠️ دور زدن محدودیت‌های جغرافیایی در سرویس‌هایی که کشور را از روی SIM تشخیص می‌دهند (مانند Google Play، TikTok و غیره)

---

## 🌐 اپراتورهای پشتیبانی‌شده

| اپراتور       | کشور            | MCCMNC |
|----------------|------------------|--------|
| Beeline        | ازبکستان         | 43404  |
| Beeline        | قزاقستان         | 40101  |
| Beeline        | روسیه            | 25099  |
| MTS            | بلاروس           | 25702  |
| MTS            | روسیه            | 25001  |
| t2             | روسیه            | 25020  |
| Tele2          | لتونی            | 24702  |
| Tele2          | سوئد             | 24007  |
| Tele2          | استونی           | 24803  |
| Megafon        | روسیه            | 25002  |
| Yota           | روسیه            | 25011  |
| A1             | بلاروس           | 25701  |
| life:)         | بلاروس           | 25704  |
| Salt           | سوئیس            | 22803  |
| Turkcell       | ترکیه            | 28601  |
| Telia          | فنلاند           | 24491  |
| Telekom        | آلمان            | 26201  |
| KPN            | هلند             | 20408  |

---

## 📦 نصب

```bash
rm -f /data/local/tmp/script.sh && \
curl -fsSL -o /data/local/tmp/script.sh https://raw.githubusercontent.com/UhExooHw/sim-spoof/refs/heads/main/data/local/tmp/script.sh && \
chmod +x /data/local/tmp/script.sh && \
sh /data/local/tmp/script.sh
```

---

## 🖥 نمونه خروجی

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

## 👤 نویسنده

GitHub: [UhExooHw](https://github.com/UhExooHw)
