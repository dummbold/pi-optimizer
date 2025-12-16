##############################################################
#!/bin/bash
# Pi Zero & LAN-HAT Optimization Script
# For Pi Zero and Zero 3 headless LAN only
#
# Version 1.0 - 12/2025
#
# Programmer: Roland Mainka
# Coder: DeutschlandGPT
# Github: https://www.github.com/dummbold/pi-optimizer
#
# For private and non-commercial use only!
#
# Disables WiFi, Bluetooth and unnecessary services for LAN-only operation
# Enables syslog for remote logging
#
# Use:# 1. Place file on your desktop
# 2. Change user@{ip} of Pi in next statement!!!!
# 2. Copy from client with: scp ~/Desktop/pi-optimizer.sh user@192.172.100.10:~
# 3. Run on Pi with: chmod +x pi-optimizer.sh && ./pi-optimizer.sh
#############################################################

set -e  # Exit on error

echo "=== Pi Zero Optimization Script ==="
echo "This script will:"
echo "- Disable WiFi and Bluetooth in boot/firmware/config.txt"
echo "- Blacklist WiFi/BT/ModemManager kernel modules"
echo "- Stop and mask related services"
echo "- Enable Syslog"
echo "- Run system update"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# 1. Backup config.txt
echo "==> Creating backup of config.txt..."
sudo cp /boot/firmware/config.txt /boot/firmware/config.txt.backup

# 1. Disable in /boot/firmware/config.txt
echo "==> Modifying /boot/firmware/config.txt..."
if ! grep -q "^dtoverlay=disable-wifi" /boot/firmware/config.txt; then
    echo "dtoverlay=disable-wifi" | sudo tee -a /boot/firmware/config.txt
fi
if ! grep -q "^dtoverlay=disable-bt" /boot/firmware/config.txt; then
    echo "dtoverlay=disable-bt" | sudo tee -a /boot/firmware/config.txt
fi

# 3. Comment out unnecessary settings in config.txt
echo "==> Disabling audio, camera, display settings..."
sudo sed -i 's/^dtparam=audio=on/#dtparam=audio=on/' /boot/firmware/config.txt
sudo sed -i 's/^camera_auto_detect=1/#camera_auto_detect=1/' /boot/firmware/config.txt
sudo sed -i 's/^display_auto_detect=1/#display_auto_detect=1/' /boot/firmware/config.txt
sudo sed -i 's/^auto_initramfs=1/#auto_initramfs=1/' /boot/firmware/config.txt
sudo sed -i 's/^dtoverlay=vc4-kms-v3d/#dtoverlay=vc4-kms-v3d/' /boot/firmware/config.txt
sudo sed -i 's/^max_framebuffers=2/#max_framebuffers=2/' /boot/firmware/config.txt

# 2. Blacklist kernel modules
echo "==> Creating blacklist file..."
sudo tee /etc/modprobe.d/raspi-blacklist.conf > /dev/null <<EOF
# Blacklist WiFi and Bluetooth modules
blacklist brcmfmac
blacklist brcmutil
blacklist btbcm
blacklist hci_uart

# Audio
blacklist snd_bcm2835
blacklist snd_pcm
blacklist snd_timer
blacklist snd

# Camera/Video
blacklist bcm2835_v4l2
blacklist bcm2835_codec
blacklist bcm2835_isp
blacklist bcm2835_mmal_vchiq

EOF

# 3. Stop services
echo "==> Stopping services..."
sudo systemctl stop bluetooth wpa_supplicant ModemManager 2>/dev/null || true

# 4. Disable services
echo "==> Disabling services..."
sudo systemctl disable bluetooth wpa_supplicant ModemManager 2>/dev/null || true

# 5. Mask services
echo "==> Masking services..."
sudo systemctl mask bluetooth wpa_supplicant ModemManager 2>/dev/null || true

# 6. Log Forwarding to remote logging device:
# Configure journald to be volatile (RAM only, no local storage)
echo "==> Configure journal..."
sudo sed -i 's/^#\?Storage=.*/Storage=volatile/' /etc/systemd/journald.conf
sudo sed -i 's/^#\?ForwardToSyslog=.*/ForwardToSyslog=yes/' /etc/systemd/journald.conf

# 7. Install rsyslog
echo "==> Installing syslog..."
echo " "
sudo apt update && sudo apt install rsyslog -y

# 8. Get IP address of remote logging device
echo " "
echo "Enter IP address of logging device (no http, just IP)"
read -p "IP: " SYSLOG_IP

# 9. Configure rsyslog for remote logging
echo "==> Configuring remote syslog forwarding..."
echo "*.* @${SYSLOG_IP}:514" | sudo tee /etc/rsyslog.d/50-remote.conf

# 10. Restart and enable services
echo "==> Restarting services..."
sudo systemctl restart systemd-journald
sudo systemctl restart rsyslog
sudo systemctl enable rsyslog

# 11. System update
echo "==> Running system update..."
echo " "
sudo apt update && sudo apt upgrade -y

echo ""
echo "=== Optimization complete! ==="
echo "Please reboot your Pi to apply all changes."
echo ""
read -p "Reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
