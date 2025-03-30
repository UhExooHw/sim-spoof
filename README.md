# 📡 ReBullet Android Scripts

## 🇬🇧 English

A set of scripts for **free mobile internet access** and **region bypass** with Beeline Russia SIM cards.

---

### 🚀 Features

- 🔄 Forces **TTL = 64** to bypass traffic filtering
- 🌐 Redirects DNS to **Cloudflare (1.1.1.1)**
- 🌍 Overrides GSM properties to simulate **Beeline Kazakhstan**
- 🧩 Designed to work via **Magisk's service.d**

---

### 📦 Installation

1. ⚠️ Your device **must be rooted** with **Magisk**
2. Open a terminal and type:

    ```sh
    su
    ```

3. Copy the scripts to:

    ```sh
    /data/adb/service.d/
    ```

4. Make them executable:

    ```sh
    chmod +x /data/adb/service.d/*.sh
    ```

5. Reboot your device. The scripts will run automatically on boot.

---

### 📁 Scripts

#### `change_operator.sh`
Overrides your SIM card's country/operator info to appear as **Beeline KZ**.

#### `spoof_ttl_dns.sh`
Spoofs TTL and forces DNS to `1.1.1.1` for DNS bypassing and region unlocking.

---

### ⚠️ Disclaimer

> **Use at your own risk.**  
> The author (ReBullet) is **not responsible** for any damage, soft-bricking, data loss, or legal issues. These scripts are provided for **educational purposes only.**

---

## 🇷🇺 Русский

Набор скриптов для **бесплатного интернета** и **обхода региональных блокировок** на симкартах Beeline Россия.

---

### 🚀 Возможности

- 🔄 Установка **TTL = 64** (обход фильтрации)
- 🌐 Замена системных DNS на **Cloudflare (1.1.1.1)**
- 🌍 Подмена параметров SIM-карты на **Beeline Казахстан**
- 🧩 Работает через **Magisk — service.d**

---

### 📦 Установка

1. ⚠️ Ваш телефон должен быть с **рут-доступом (Magisk)**
2. Введите в терминале:

    ```sh
    su
    ```

3. Скопируйте скрипты в:

    ```sh
    /data/adb/service.d/
    ```

4. Сделайте их исполняемыми:

    ```sh
    chmod +x /data/adb/service.d/*.sh
    ```

5. Перезагрузите устройство. Скрипты запустятся автоматически.

---

### 📁 Скрипты

#### `change_operator.sh`
Меняет информацию о SIM-карте на **Beeline KZ**

#### `spoof_ttl_dns.sh`
Подменяет TTL и DNS на `1.1.1.1` для обхода блокировок.

---

### ⚠️ Дисклеймер

> **Вы используете это на свой страх и риск.**  
> Автор (ReBullet) **не несёт ответственности** за возможный ущерб, потерю данных или блокировки устройства. Эти скрипты предоставлены **в образовательных целях.**

---

