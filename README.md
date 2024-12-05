# Aurora Android Optimizer
Experience faster, more efficient Android with Aurora!

---

## Overview

Welcome to **Aurora Android Optimizer**, a powerful solution to optimize performance, extend battery life, and remove bloatware from Android devices. This tool is designed with automation and simplicity in mind, integrating **ADB** and Bash scripts into an automatically configured environment. This documentation will guide you through features, installation, and usage, providing all necessary technical details.

---

## **Introduction**

**Aurora Android Optimizer** uses ADB commands to access advanced Android functionality, allowing you to:

1. **Optimize battery and performance**.
2. **Remove bloatware** (pre-installed applications).
3. **Export installed packages for analysis**.
4. **Automate ADB configuration processes** for Windows, Linux, and Termux (Android).
5. **Revert changes for enhanced security**.

It is designed to run with minimal effort, automatically configuring the execution environment requirements.

---

## **Prerequisites**

Before running Aurora Android Optimizer, you need to enable **Developer Options** on your Android device.

### 1. Enabling Developer Options
1. Go to **Settings > About Phone**.
2. Tap **Build Number** (or a similar option) **7 times or more**.
3. Enter your password if prompted. **Developer Options** will now be available in the settings menu.

### 2. Configuring ADB Debugging
Choose between **USB Debugging** or **Wi-Fi Debugging**:

#### **Option 1: USB Debugging**
1. Enable **USB Debugging** in **Developer Options**.
2. Connect your device to the computer via a USB cable.
3. Approve the ADB connection prompt on your device.

Verify the connection by running:
```bash
adb devices
```

Your device should appear in the list.

#### **Option 2: Wi-Fi Debugging**
1. Enable **Wi-Fi Debugging** in **Developer Options**.
2. Select **Pair Device with a Code**, which will display:
   - IP address
   - Port
   - Pairing code
3. In the terminal, run:
   ```bash
   adb pair <IP_ADDRESS>:<PORT> <PAIRING_CODE>
   ```
   After successful pairing, connect with:
   ```bash
   adb connect <IP_ADDRESS>:<PORT>
   ```

   **Note**: The IP address and port can be found on the Wi-Fi Debugging screen.

---

## **How to Use**

### **1. Windows**
On Windows, the script automatically configures ADB, Git, and the required environment. Run the following command in **PowerShell** with administrator privileges:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://raw.githubusercontent.com/azurejoga/aurora-android-optimizer/refs/heads/master/windows.ps1 -OutFile windows.ps1; .\windows.ps1
```

This command will:
- Install Git and ADB (if not already installed).
- Configure the environment to run Bash scripts.
- Start the main optimization script.

---

### **2. Linux**
On Linux, the script automatically configures prerequisites and runs optimization commands. Use the command below:

```bash
curl -o linux.sh https://raw.githubusercontent.com/azurejoga/aurora-android-optimizer/refs/heads/master/linux.sh && chmod +x linux.sh && ./linux.sh
```

---

### **3. Android (Termux)**
First, install Termux. [Click here](https://github.com/termux/termux-app/releases#js-repo-pjax-container) to download the app.

In Termux, the script installs ADB and configures the environment. Run the following command:

```bash
pkg install proot -y && termux-chroot && pkg install curl -y && curl -o android.sh https://github.com/azurejoga/aurora-android-optimizer/raw/refs/heads/master/android.sh && chmod +x android.sh && ./android.sh
```

---

## **Features**

Aurora Android Optimizer offers a set of ready-to-use commands for system optimization. Key features include:

### 1. **Bloatware Removal**
Remove unwanted pre-installed apps. Currently compatible with Samsung devices.

### 2. **Battery Optimization**
Execute ADB commands to reduce power consumption and improve battery life. Compatible with all Android devices.

### 3. **Performance Improvement**
Make adjustments to increase device speed and fluidity. Compatible with all Android devices.

### 4. **Export Installed Packages**
Generate a `.txt` file listing all installed packages for analysis.

### 5. **Revert Changes**
Undo all applied modifications to ensure security.

---

## **Warnings and Recommendations**

- **Backup**: Always create a full backup of your device before making changes.
- **Risks**: Improper use of ADB can lead to system issues. Use scripts responsibly.
- **Responsibility**: We are not liable for any damages or issues caused by the use of Aurora Android Optimizer.

---

## **Compatibility**

- **Bloatware Removal**: Supported for Samsung devices only.
- **Optimization Features**: Compatible with any Android device supporting ADB.

---

## **Contribute**

To contribute, open a pull request (PR) or create an issue.  
If you want to support other brands, see the example script in  
[/scripts/Samsung.sh](https://github.com/azurejoga/aurora-android-optimizer/blob/master/scripts/samsung.sh)  
and adapt it for the desired brand.

Don't forget to reference it in [main.sh](https://github.com/azurejoga/aurora-android-optimizer/blob/master/scripts/main.sh) so the tool recognizes support for new brands.

---

Thank you for using Aurora Android Optimizer.  
If you have questions or suggestions, contribute to the [official repository on GitHub](https://github.com/azurejoga/aurora-android-optimizer).
