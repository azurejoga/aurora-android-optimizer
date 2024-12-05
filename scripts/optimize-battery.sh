#!/bin/bash

# List of commands with descriptions
commands=(
    "background_process_limit:Limit background processes to 1"
    "cached_apps_freezer:Enable suspend for cached apps"
    "always_finish_activities:Close activities when leaving"
    "ram_plus_feature_enabled:Disable RAM+"
    "app_hibernation_enabled:Enable application hibernation"
    "adaptive_battery_management_enabled:Enable Adaptive Battery Management"
    "wifi_scan_always_enabled:Disable constant Wi-Fi scanning"
    "ble_scan_always_enabled:Disable constant Bluetooth scanning"
    "location_accuracy_enabled:Disable Google Location Accuracy"
    "usage_reporting_enabled:Disable sending data and diagnostics"
    "auto_update_apps:Disable automatic Play Store updates"
    "wifi_scan_throttle_enabled:Habilitar Wi-Fi scanning limitation"
    "preferred_network_mode:Force use of 4G network instead of 5G"
    "auto_sync:Disable automatic sync"
    "double_tap_to_wake:Disable double tap to wake screen"
    "screen_brightness_mode:Enable adaptive brightness"
    "screen_resolution:Reduce screen resolution"
    "screen_density:Adjust screen density"
    "disable_wellbeing:Desativar o Bem-Estar Digital"
)

# Function to apply commands individually
apply_command() {
    key=$1
    value=$2
    description=$3

    echo "Do you want to apply the configuration: $description? (y/n)"
    read -r choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
        case $key in
            "screen_resolution")
                adb shell wm size 1080x1920
                ;;
            "screen_density")
                adb shell wm density 400
                ;;
            "disable_wellbeing")
                adb shell pm disable-user com.google.android.apps.wellbeing
                ;;
            *)
                adb shell settings put global "$key" "$value"
                ;;
        esac
        echo "Applied configuration: $description"
    else
        echo "Configuration ignored: $description"
    fi
}

# Function to restore settings
revert_commands() {
    echo "Reverting settings to defaults..."
    adb shell settings delete global device_idle_constants
    adb shell settings delete global background_process_limit
    adb shell settings delete global cached_apps_freezer
    adb shell settings delete global always_finish_activities
    adb shell settings delete global ram_plus_feature_enabled
    adb shell settings delete global app_hibernation_enabled
    adb shell settings delete global adaptive_battery_management_enabled
    adb shell settings delete global wifi_scan_always_enabled
    adb shell settings delete global ble_scan_always_enabled
    adb shell settings delete secure location_accuracy_enabled
    adb shell settings delete global usage_reporting_enabled
    adb shell settings delete global auto_update_apps
    adb shell settings delete global wifi_scan_throttle_enabled
    adb shell settings delete global preferred_network_mode
    adb shell settings delete global auto_sync
    adb shell settings delete global double_tap_to_wake
    adb shell settings delete system screen_brightness_mode
    adb shell wm size reset
    adb shell wm density reset
    adb shell pm enable com.google.android.apps.wellbeing
    echo "Settings reverted to defaults!"
}

# Ask the user if they want to restore default settings before continuing
echo "Do you want to restore the default battery optimization settings before continuing? (y/n/c)"
read -r reset_choice

if [[ $reset_choice == "y" || $reset_choice == "Y" ]]; then
    revert_commands
elif [[ $reset_choice == "c" || $reset_choice == "C" ]]; then
    echo "Continuing without restoring default settings..."
fi

# Apply commands one by one
for cmd in "${commands[@]}"; do
    key=$(echo "$cmd" | cut -d':' -f1)
    description=$(echo "$cmd" | cut -d':' -f2)

    if [[ $key == "screen_resolution" || $key == "screen_density" ]]; then
        apply_command "$key" "" "$description"
    else
        apply_command "$key" 1 "$description"
    fi
done

echo "All settings have been processed!"
