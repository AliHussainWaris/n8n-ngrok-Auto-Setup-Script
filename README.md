# n8n + ngrok Auto Setup Script
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

## Overview

**n8n + ngrok Auto Setup Script** is a **Windows automation tool** that simplifies running **n8n** with **publicly accessible webhooks** via ngrok.  

With this script, you no longer need to manually configure URLs, environment variables, or restart n8n every time you want to expose your workflows to the internet. It’s designed for **developers, automation enthusiasts, and anyone using n8n on Windows** who wants a hassle-free setup.

## Features

- Fully automates starting **n8n** and **ngrok**.  
- Detects the current Windows user and updates `.env` in the correct `.n8n` folder.  
- Automatically extracts **ngrok public URL** from the local ngrok API.  
- Updates environment variables:  
  - `WEBHOOK_URL`  
  - `VUE_APP_URL_BASE_API`  
- Kills and restarts n8n safely to apply the new configuration.  
- Works for **any Windows account** without manual changes.  

---

## How It Works

1. Kills any existing n8n process to avoid conflicts.  
2. Starts **n8n** in the background.  
3. Starts **ngrok** and waits for a public URL.  
4. Reads the ngrok JSON API to extract the `public_url`.  
5. Creates/updates `.env` in `C:\Users\<USERNAME>\.n8n`.  
6. Restarts n8n to apply the updated environment variables.  
7. Displays the **ngrok public URL** for easy use in workflows.

---
## Prerequisites

Before using the script, ensure you have:

- **Windows 10/11**  
- [Node.js](https://nodejs.org/) installed  
- [n8n](https://n8n.io/) installed globally:  

  ```bash
  npm install -g n8n bash 
  ```
- [Ngrok](https://ngrok.com/downloads/windows) installed
  ``` bash
   ngrok authtoken <YOUR_NGROK_TOKEN>
  ```
---
## Setup Instruction

1. **Clone the repository**
   ``` bash
    https://github.com/AliHussainWaris/n8n-ngrok-Auto-Setup-Script.git
    cd n8n-ngrok-Auto-Setup-Script
   ```
2. **Run the batch script by double-clicking `n8n-auto.bat` or in CMD**
   ``` bash
    n8n_ngrok_auto_script.bat
   ```
3. **The script will:**
   - Start n8n
   - Start ngrok and detect the public URL
   - Create or update ```.env``` in the current user’s ```.n8n``` folder
   - Restart n8n
   - Display the ngrok URL
   

## Example ```.env``` Created
```bash
 N8N_HOST=0.0.0.0
 N8N_PORT=1234
 WEBHOOK_URL=https://abcdef12345.ngrok-free.app/
 VUE_APP_URL_BASE_API=https://abcdef12345.ngrok-free.app/
```

## Usage
 - Open your n8n editor using the ngrok URL printed at the end of the script.
 - Use this URL for workflows and webhooks that require public access.

## Contributing

Contributions are welcome! You can:

 - Report bugs or issues
 - Suggest new features
 - Improve the batch script or documentation
 - Please open a pull request or issue on GitHub.

## License

[MIT](https://choosealicense.com/licenses/mit/)
