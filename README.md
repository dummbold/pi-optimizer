# Pi-Optimizer

## DEUTSCH 🇩🇪
Der Pi-Optimizer ist ein Unix Shellscript für Raspberry Pi computer die "headless" (also ohne Monitor und Tastatur) arbeiten sollen. Diese benötigen eine Reihe von Funktionen nicht, die standardmäßig im Pi-OS installiert sind, geladen werden und RAM und CPU-Leistung benötigen. Durch das Script werden diese Funktionen ausgeschaltet - und zwar nachhaltig! Oftmals reicht ein einfaches abschalten in der /boot/firmware/config.txt nicht. Sie müssen noch zusätzlich auf die "Blacklist" gesetzt werden. All das macht das Script interaktiv.

Im Einzelnen betrifft das folgende Funktionen:

- WiFi
- Bluetooth
- Audio
- Kamera/Video
- Basiskonfiguration für Monitoranschluss
- Modemmanager

Die Grundkonfiguration für USB wurde belassen - das kann man ja meistens brauchen.

Ich selbst nutze diese Konfiguration für meine Projekte MQTT•Freund (Pi Zero 2 WH) und meinen Pi-Hole (Pi Zero W). Das Script sollte aber prinzipiell auf allen Raspberry Pi Computern laufen.


## English 🇺🇸🇬🇧
The Pi-Optimizer is a Unix shell script for Raspberry Pi computers that are intended to run "headless" (without a monitor and keyboard). These systems do not require a number of functions that are installed and loaded by default in Pi-OS, consuming RAM and CPU power. The script disables these functions – permanently! Often, simply turning them off in the /boot/firmware/config.txt file is not enough. They must also be added to the "blacklist." The script handles this interactively.

Specifically, the following functions are affected:

- WiFi
- Bluetooth
- Audio
- Camera/Video
- Basic monitor connection configuration
- Modem manager

The base configuration for USB has been retained, as it is usually needed.

I personally use this configuration for my MQTT•Freund project (Pi Zero 2 WH) and my Pi-Hole (Pi Zero W). However, the script should generally work on all Raspberry Pi computers.
