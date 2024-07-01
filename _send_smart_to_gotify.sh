#!/bin/bash

# Hard Disks
disks=("/dev/nvme0n1" "/dev/sdb" "/dev/sdc")

# Gotify Settings
gotify_url="http://your-gotify-server-url/message"
gotify_token="your-application-token"

# Path for smartctl 
smartctl_path="/usr/bin/smartctl"

# function for smart value 
get_smart_values() {
    local disk=$1
    temperature=$($smartctl_path -A $disk | awk '/Temperature_Celsius/ {print $10}')
    health=$($smartctl_path -H $disk | awk '/SMART overall-health self-assessment test result/ {print $6}')
    echo -e "Temperature: $temperature°C\nHealth Status: $health"
}

# send smart value to gotify
for disk in "${disks[@]}"; do
    smart_values=$(get_smart_values $disk)
    title="SMART Werte für $disk"
    
    curl -F "title=$title" \
         -F "message=$smart_values" \
         -F "priority=5" \
         "$gotify_url?token=$gotify_token"
done
