## GitHub Script: SMART Value Monitoring for Gotify

This script monitors SMART values of specified drives and sends notifications using Gotify. Below is a step-by-step guide to set up and use this script.

### Requirements

- **Operating System:** Linux
- **Dependencies:** `smartmontools`, `curl`
- **Gotify Server:** Access to a Gotify server and a valid token for sending messages.

### Script Setup

1. **Install Required Packages:**
   Ensure `smartmontools` and `curl` are installed. If not, install them using your package manager. For example, on Debian/Ubuntu:

   ```bash
   sudo apt-get update
   sudo apt-get install smartmontools curl
   ```

2. **Script Configuration:**
   Edit the script (`smart-monitor.sh`) to configure paths, drive list, and Gotify settings.

   ```bash
   #!/bin/bash
   
   # Set path for smartctl tool
   export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
   
   # Drives to monitor (replace with actual device paths)
   disks=("/dev/sdb" "/dev/sdc")
   
   # Gotify Server Settings
   gotify_url="https://your-gotify-server/message"
   gotify_token="your-gotify-server-token"
   ```

   Adjust the `disks` array to include the drives you want to monitor. Replace `"/dev/sdb"`, `"/dev/sdc"` with your actual drive paths.

3. **SMART Value Function:**
   The function `get_smart_values()` retrieves temperature and health status for a specified drive using `smartctl`.

   ```bash
   get_smart_values() {
       local disk=$1
       temperature=$(smartctl -A $disk | awk '/Temperature_Celsius/ {print $10}')
       health=$(smartctl -H $disk | awk '/SMART overall-health self-assessment test result/ {print $6}')
       if [[ $disk == "/dev/nvme0n1" ]]; then
           echo -e "Health Status der Festplatte: $health"  # Example: Translate or adjust messages as needed
       else
           echo -e "Temperature: $temperature°C\nHealth Status: $health"
       fi
   }
   ```

   Modify the echo statements for localized or specific output requirements.

4. **Sending Notifications:**
   The main loop retrieves SMART values for each disk and sends them to Gotify using `curl`.

   ```bash
   for disk in "${disks[@]}"; do
       smart_values=$(get_smart_values $disk)
       title="SMART Value of $disk"
       
       curl -F "title=$title" \
            -F "message=$smart_values" \
            -F "priority=5" \
            "$gotify_url?token=$gotify_token"
   done
   ```

   Adjust `priority=5` as needed for Gotify message priority.

### Usage

- **Run the Script:**
  Make the script executable and run it manually or via cron for periodic monitoring.

  ```bash
  chmod +x smart-monitor.sh
  ./smart-monitor.sh
  ```

- **Automate with Cron:**
  To run the script periodically (e.g., every hour), edit your crontab:

  ```bash
  crontab -e
  ```

  Add the following line to run the script every hour:

  ```bash
  0 * * * * /path/to/smart-monitor.sh > /dev/null 2>&1
  ```

  Replace `/path/to/smart-monitor.sh` with the actual path to your script.

### Conclusion

This script provides a straightforward method to monitor SMART values of specified drives and send notifications using Gotify. Customize it further based on your specific needs or environment configurations.
