<p align="right"><img width="220" height="52" alt="dgpt" src="https://github.com/user-attachments/assets/e763407f-dff7-4a2b-9bbd-d04cf14373ff" /></p>



>🇺🇸🇬🇧🇫🇷🇪🇸🇮🇹🇪🇺🇺🇦🇦🇺🇫🇮🇨🇿🇧🇷🇨🇦🇰🇿🇨🇴🇲🇶🇳🇬🇸🇨🇪🇭🇺🇾🇺🇬🏳️🏴‍☠️
>
>__International users: Please use your Browsers translation feature. This Text is written in german language. A translation from german into other languages mainly generates better results then a translation from any language into german. Thanks for your compliance.__
>

# PiPutzer ("PiCleaner")

Der PiPutzer ist ein Unix Shellscript für Raspberry Pi computer die "headless" (also ohne Monitor und Tastatur) arbeiten sollen. Diese benötigen eine Reihe von Funktionen nicht, die standardmäßig im Pi-OS installiert sind, geladen werden und RAM und CPU-Leistung benötigen. Durch das Script werden diese Funktionen ausgeschaltet - und zwar nachhaltig! Oftmals reicht ein einfaches Abschalten in der /boot/firmware/config.txt nicht. Sie müssen noch zusätzlich auf die "Blacklist" gesetzt werden. All das macht das Script interaktiv.

Im Einzelnen betrifft das folgende Funktionen:

- WiFi
- Bluetooth
- Audio
- Kamera/Video
- Basiskonfiguration für Monitoranschluss
- Modemmanager

Die Grundkonfiguration für USB wurde belassen - das kann man ja meistens brauchen.

Ich selbst nutze diese Konfiguration für meine Pi Projekte mit Pi Zero mit LAN-HAT. Das Script sollte aber prinzipiell auf allen Raspberry Pi Computern laufen.

ACHTUNG: die Funktionen werden NICHT GELÖSCHT - nur abgeschaltet. Sie können also jederzeit wieder aktiviert werden!
