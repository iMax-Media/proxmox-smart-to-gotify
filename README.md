### SMART Values Monitoring and Notification Script for Gotify

#### Introduction
This repository hosts a script designed to monitor and report SMART (Self-Monitoring, Analysis, and Reporting Technology) values from specified disks to a Gotify server. SMART values provide crucial insights into the health and performance of hard drives, allowing proactive maintenance and monitoring.

#### Prerequisites
Before using the script, ensure you have the following set up:
- **Gotify Server**: Set up and configure a Gotify server for receiving push notifications. For Gotify server setup instructions, visit [Gotify GitHub Repository]([https://github.com/gotify/server](https://github.com/gotify/server)).
- **Create a Gotify Application**: Generate an application token by creating a new application on your Gotify server. This token will be used for authentication when sending notifications.
- make sure you have installed smartctl
- you can check this on terminal when you type "smartctl" -> to install you can use apt-get install smartctl

#### Installation and Setup

##### Step 1: Clone the Repository
Clone this repository to your local machine:
```bash
git clone (https://github.com/iMax-Media/proxmox-smart-to-gotify.git)
cd repository
```

##### Step 2: Configure the Script
1. Open `send_smart_to_gotify.sh` in a text editor.
2. Update the following variables:
   - `gotify_url`: Set this to your Gotify server URL.
   - `gotify_token`: Replace with the application token generated from Gotify.

##### Step 3: Set Permissions
Make the script executable:
```bash
chmod +x send_smart_to_gotify.sh
```

#### Usage

##### Step 4: Schedule Cron Jobs
Schedule the script to run at regular intervals using cron jobs:
```bash
# Example: Run the script daily at 7:15 AM and 8:00 PM
15 7 * * * /path/to/send_smart_to_gotify.sh
0 20 * * * /path/to/send_smart_to_gotify.sh
```

##### Step 5: Execute and Monitor
1. Manually execute the script to ensure proper functionality:
   ```bash
   ./send_smart_to_gotify.sh
   ```

2. Monitor Gotify notifications to verify SMART data is received correctly.

#### Script Details
- **Functionality**: 
  - Retrieves SMART values (specifically temperature and health status) from specified disks using `smartctl`.
  - Constructs a notification message and sends it to the configured Gotify server using `curl`.

- **Customization**: 
  - Customize the script to include additional SMART attributes or modify notification formatting as needed.

#### Troubleshooting
- **Permissions**: Ensure the script has executable permissions (`chmod +x`).
- **Gotify Configuration**: Double-check the server URL and application token used in the script.

#### Additional Notes
- Ensure `smartctl` and `curl` are installed and accessible on your system. Install them via your package manager if needed.

#### Conclusion
This script automates the monitoring of SMART values for your disks and sends notifications via Gotify, facilitating proactive disk health management and monitoring.

---
