#!/bin/bash

# set path for the smart-value tool
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Drives
disks=("example ""/dev/sdb" "/dev/sdc")

# Gotify Settings
gotify_url="your-gotify-server/message"
gotify_token="your-gotify-server-token"

# function for SMART-Value
get_smart_values() {
    local disk=$1
    temperature=$(smartctl -A $disk | awk '/Temperature_Celsius/ {print $10}')
    health=$(smartctl -H $disk | awk '/SMART overall-health self-assessment test result/ {print $6}')
    if [[ $disk == "/dev/nvme0n1" ]]; then #in case of an NVMe drive #
        echo -e "Health Status der Festplatte: $health"
    else
        echo -e "Temperature: $temperature°C\nHealth Status: $health"
    fi
}

# get SMART-Value and send it to gotify
for disk in "${disks[@]}"; do
    smart_values=$(get_smart_values $disk)
    title="SMART Value of $disk"
    
    curl -F "title=$title" \
         -F "message=$smart_values" \
         -F "priority=5" \
         "$gotify_url?token=$gotify_token"
done
