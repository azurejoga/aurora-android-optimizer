# aurora-android-optimizer
Experience faster more efficient Android with Aurora!

# Overview

Welcome to **Aurora Android Optimizer**, a powerful solution to optimize performance, battery, performance and remove bloattware from Android devices. We developed this tool with a focus on automation and simplicity, integrating **ADB** and Bash scripts into an automatically configured environment. This documentation will guide you through features, installation and usage, providing all necessary technical details.

---

## **Introduction**

**Aurora Android Optimizer** uses ADB commands to access advanced Android functionality, allowing you to:

1. **Battery and performance optimization**.
2. **Bloatware removal** (pre-installed applications).
3. **Export of installed packages for analysis**.
4. **Automation of ADB configuration processes** for Windows, Linux and Termux (Android).
5. **Revert changes for greater security**.

It is designed to run with minimal effort on the part of the user by automatically configuring requirements in the execution environment.

---

## **Prerequisites**

Before running Aurora Android Optimizer, you need to enable **Developer Options** on your Android device.

### 1. Enabling Developer Options
1. Go to **Settings > About phone**.
2. Click **7 times or more** on the **Version Number or / build**.
3. Enter the password if prompted. **Developer Options** will be available in the settings menu.

### 2. Configuring ADB Debugging
Choose between **USB Debugging** or **Wi-Fi Debugging**:

#### **Option 1: USB Debugging**
1. Enable **USB Debugging** in **Developer Options**.
2. Connect your device to computer via USB cable.
3. Allow ADB connection on your device when prompted.

Enter

adb devices

 to see if your device is on the list.


#### **Option 2: Wi-Fi Debugging**
1. Enable **Wi-Fi Debugging** in **Developer Options**.
2. Click **Pair with a code** to get:
   - IP address
   - port
   - Pairing code
3. In the terminal, run:
   ```bash
   adb pair 192.168.x.x port code

Then, upon successful pairing

   adb connect 192.168.x.x:port
   ```
   **Note**: The IP address and connection port can be viewed on the initial Wi-Fi Debug screen. For pairing, the address and port will be available on the same screen where the 6-digit code appears

---

## **How to use**

### **1. Windows**
On Windows, the script automatically configures ADB, Git and the required environments. Run the following command in **PowerShell** with administrator permissions:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest -Uri https://raw.githubusercontent.com/azurejoga/aurora-android-optimizer/refs/heads/master/windows.ps1 -OutFile windows.ps1; .\windows.ps1
```

This command will:
- Install Git and ADB, if they are not present.- Configure the environment to run Bash scripts.
- Start the main optimization script.

---

### **2. Linux**
On Linux, the main script automatically configures prerequisites and runs optimization commands. Use the command below:

```bash
curl -o linux.sh https://raw.githubusercontent.com/azurejoga/aurora-android-optimizer/refs/heads/master/linux.sh && chmod +x linux.sh && ./linux.sh
```

---

### **3. Android (Termux)**
You need to install termux first, to do this
[click here](https://github.com/termux/termux-app/releases#js-repo-pjax-container)

In Termux, the script installs ADB and configures the environment. Run the command below:

```bash
pkg install proroot -y && termux-chroot && pkg install curl -y && curl -o android.sh https://github.com/azurejoga/aurora-android-optimizer/raw/refs/heads/master/android.sh && chmod +x android.sh && ./android.sh
```

---

## **Features**

Aurora Android Optimizer offers a set of ready-made commands to perform system optimizations. Below are the main features:

### 1. **Bloatware Removal**
However, Compatible with Samsung devices, you can remove unwanted pre-installed apps.

### 2. **Battery Optimization**
Runs ADB commands that reduce power consumption and improve battery life, compatible with any phone.

### 3. **Performance Improvement**
Make adjustments to increase the speed and fluidity of the device, compatible with any phone

### 4. **Export of Installed Packages**
Generates a `.txt` file with all packages installed on the device for later analysis.

### 5. **Reversal of Changes**
Includes an option to undo all applied modifications, ensuring security.

---


## **Warnings and Recommendations**

- **Backup**: Before making any changes, make a complete backup of your device.
- **Risks**: Improper use of ADB can cause system problems. Use scripts carefully.
- **Responsibility**: We are not responsible for damages or problems caused by the use of Aurora Android Optimizer.

---

## **Compatibility**

Currently, bloatware removal support is only available for **Samsung** devices.Optimization features are compatible with any Android device that supports ADB.

---
## Contribute
To contribute, open a pullrequest, PR, or an issue.
Alternatively, if you want to support other brands, see the example script at
[/scripts/Samsung.sh](https://github.com/azurejoga/aurora-android-optimizer/blob/master/scripts/samsung.sh)

And adapt according to the brand you want to support.
Don't forget to reference in [main.sh](https://github.com/azurejoga/aurora-android-optimizer/blob/master/scripts/main.sh)
so he understands that we have new brands!


Thank you for using Aurora Android Optimizer. If you have questions or suggestions, contribute to the [official repository on GitHub](https://github.com/azurejoga/aurora-android-optimizer).
