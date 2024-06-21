Introduction
This repository contains a script designed to retrieve SMART (Self-Monitoring, Analysis, and Reporting Technology) values from specified disks and send them to a Gotify server. SMART values provide insights into the health and performance of hard drives. Gotify is a self-hosted push notification server that can be used to receive and display notifications.

Prerequisites
Before using the script, ensure the following prerequisites are met:

Gotify Server Setup:
Set up and configure a Gotify server. For more information, visit Gotify GitHub Repository.
Create a new application on your Gotify server and generate an application token. This token will be used to authenticate the script when sending notifications.
Steps to Use the Script
Step 1: Configure Gotify
Create a New Application:
Log in to your Gotify server.
Navigate to the Applications section.
Create a new application and note down the generated application token.
Step 2: Set Up the Script
Clone the Repository:

bash
Code kopieren
git clone https://github.com/your/repository.git
cd repository
Edit the Script:

Open send_smart_to_gotify.sh in a text editor.
Update the gotify_url variable with your Gotify server URL and gotify_token with the application token generated in Step 1.
Ensure Permissions:

Make the script executable:
bash
Code kopieren
chmod +x send_smart_to_gotify.sh
Step 3: Schedule Cron Jobs
Schedule Script Execution:
Use cron jobs to schedule the script to run at desired intervals. For example:
bash
Code kopieren
# **As an example** Run the script daily at 7:15 AM and 8:00 PM
15 7 * * * /path/to/send_smart_to_gotify.sh
0 20 * * * /path/to/send_smart_to_gotify.sh
Step 4: Run and Monitor
Run the Script:

Manually execute the script to ensure it runs without errors:
bash
Code kopieren
./send_smart_to_gotify.sh
Monitor Gotify Notifications:

Check your Gotify dashboard or client application to verify SMART notifications are received correctly.
Script Details
Script Functionality:

The script retrieves SMART values (specifically temperature and health status) from specified disks using smartctl.
Constructs a notification message with these values and sends it to the specified Gotify server using curl.
Customization:

You can customize the script to include additional SMART attributes or modify the notification format as per your requirements.
Troubleshooting
Permissions: Ensure the script has executable permissions.
Gotify Configuration: Double-check the Gotify server URL and application token used in the script.
Additional Notes
This script assumes smartctl and curl are installed and accessible on your system. Install them using your package manager if they are not already installed.
Conclusion
By following these steps, you can automate the monitoring of SMART values for your disks and receive notifications via Gotify, helping you to proactively manage disk health and performance.

