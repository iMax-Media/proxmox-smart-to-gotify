#!/bin/bash

# Festplatten
disks=("/dev/nvme0n1" "/dev/sdb" "/dev/sdc")

# Gotify Einstellungen
gotify_url="http://your-gotify-server/message"
gotify_token="your-own-token"

# Funktion zum Abrufen der SMART-Werte
get_smart_values() {
    local disk=$1
    temperature=$(smartctl -A $disk | awk '/Temperature_Celsius/ {print $10}')
    health=$(smartctl -H $disk | awk '/SMART overall-health self-assessment test result/ {print $6}')
    echo -e "Temperature: $temperature°C\nHealth Status: $health"
}

# SMART-Werte abrufen und an Gotify senden
for disk in "${disks[@]}"; do
    smart_values=$(get_smart_values $disk)
    title="SMART Werte für $disk"
    
    curl -F "title=$title" \
         -F "message=$smart_values" \
         -F "priority=5" \
         "$gotify_url?token=$gotify_token"
done
