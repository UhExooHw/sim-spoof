#!/system/bin/sh
# Author: ReBullet

while true; do
    resetprop gsm.operator.iso-country kz
    resetprop gsm.sim.operator.iso-country kz
    resetprop gsm.operator.numeric 40101
    resetprop gsm.sim.operator.numeric 40101
    resetprop gsm.operator.alpha "Beeline"
    resetprop gsm.sim.operator.alpha "Beeline"
    resetprop persist.sys.timezone Asia/Almaty
    resetprop persist.sys.country KZ
    sleep 10
done
