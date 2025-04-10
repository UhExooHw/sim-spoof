# 🚀 ReBullet SIM Spoof

> ⚠️ **Внимание:** Использование скрипта может нарушать законы или условия оператора. Всё — **на ваш страх и риск**.  
> ⚠️ Работает **только с SIM1**. SIM2 не поддерживается. TTL spoof **не гарантирует** обход всех ограничений.

---

## ⚙️ Требования

- Android 9+ (API 28)
- Magisk 20.4+
- iptables
- Ядро с TCP BBR (опц.)

---

## 💡 Возможности

- 🌍 Подмена SIM: MCCMNC, ISO оператора
- 🌍 Подмена Таймзоны
- 🔐 Перехват DNS и DoT (DNS over TLS)
- 🚀 Активация TCP BBR
- 📶 TTL=64 spoof
- ⚠️ Обход геоблокировок в сервисах, определяющих страну по SIM-карте (Google Play, TikTok, YouTube и др.)

---

## 🌐 Поддержка операторов

| Оператор   | Страна        | MCCMNC |
|------------|---------------|--------|
| Beeline    | Uzbekistan    | 43404  |
| Beeline    | Russia        | 25099  |
| MTS        | Belarus       | 25702  |
| MTS        | Russia        | 25001  |
| Tele2      | Russia        | 25020  |
| Tele2      | Latvia        | 24702  |
| Megafon    | Russia        | 25002  |
| Yota       | Russia        | 25011  |
| A1         | Belarus       | 25701  |
| life:)     | Belarus       | 25704  |
| Turkcell   | Turkey        | 28601  |
| Salt       | Switzerland   | 22803  |

---

## 📦 Установка

```bash
curl -s -o /data/local/tmp/spoof.sh \
  https://raw.githubusercontent.com/UhExooHw/sim-spoof/main/spoof.sh \
  && chmod +x /data/local/tmp/spoof.sh \
  && sh /data/local/tmp/spoof.sh
```

---

## 🖥 Пример вывода

```
[✓] BBR is supported by the kernel.
[✓] Environment OK.

Select Mobile Operator:
  [1] Beeline     [2] MTS
  [3] Tele2       [4] Megafon
  [5] Yota        [6] A1
  [7] life:)      [8] Turkcell
  [9] Salt

Select DNS Provider:
  [1] Cloudflare (1.1.1.1)
  [2] Google     (8.8.8.8)
  [3] Quad9      (9.9.9.9)

[✓] Scripts installed:
    /data/adb/service.d/ReBullet-SIM.sh
    /data/adb/service.d/ReBullet-TTL.sh

Reboot required to apply changes.
```

---

## 👤 Автор

GitHub: [UhExooHw](https://github.com/UhExooHw)
```

---

Хочешь, чтобы я сразу сгенерировал патч и для скрипта — с добавлением Salt?
