#!/bin/bash

# Function to restore settings
revert_commands() {
    echo "Reverting settings to defaults..."
    adb shell settings delete global window_animation_scale
    adb shell settings delete global transition_animation_scale
    adb shell settings delete global animator_duration_scale
    adb shell settings delete system rakuten_denwa
    adb shell settings delete system send_security_reports
    adb shell settings delete secure send_action_app_error
    adb shell settings delete global activity_starts_logging_enabled
    adb shell settings delete secure gamesdk_version
    adb shell settings delete secure game_home_enable
    adb shell settings delete secure game_bixby_block
    adb shell settings delete secure game_auto_temperature_control
    adb shell settings delete global disable_window_blurs
    adb shell settings delete global accessibility_reduce_transparency
    adb shell settings delete global zram_enabled
    adb shell settings delete global ram_expand_size_list
    adb shell settings delete secure long_press_timeout
    adb shell settings delete secure multi_press_timeout
    adb shell settings delete secure tap_duration_threshold
    adb shell settings delete secure touch_blocking_period
    adb shell settings delete system peak_refresh_rate
    adb shell settings delete system min_refresh_rate
    adb shell cmd power set-fixed-performance-mode-enabled false
    adb shell settings delete global private_dns_mode
    adb shell settings delete global private_dns_specifier
    adb shell settings delete global wifi_power_save
    adb shell settings delete global enable_cellular_on_boot
    adb shell settings delete global mobile_data_always_on
    adb shell settings delete global tether_offload_disabled
    adb shell settings delete global ble_scan_always_enabled
    adb shell settings delete global network_scoring_ui_enabled
    adb shell settings delete global network_recommendations_enabled
    adb shell settings delete system intelligent_sleep_mode
    adb shell settings delete secure adaptive_sleep
    adb shell settings delete global app_restriction_enabled
    adb shell settings delete global automatic_power_save_mode
    adb shell settings delete global sem_enhanced_cpu_responsiveness
    adb shell settings delete global adaptive_battery_management_enabled
    echo "Settings restored."
}

# List of commands with associated messages
declare -A commands=(
    ["Disable animations"]="adb shell settings put global window_animation_scale 0.0 && adb shell settings put global transition_animation_scale 0.0 && adb shell settings put global animator_duration_scale 0.0"
    ["Speed ​​up app launch"]="adb shell settings put system rakuten_denwa 0 && adb shell settings put system send_security_reports 0 && adb shell settings put secure send_action_app_error 0 && adb shell settings put global activity_starts_logging_enabled 0"
    ["Disable game optimization (Samsung)"]="adb shell settings put secure gamesdk_version 0 && adb shell settings put secure game_home_enable 0 && adb shell settings put secure game_bixby_block 1 && adb shell settings put secure game_auto_temperature_control 0 && adb shell pm clear --user 0 com.samsung.android.game.gos"
    ["Adjust refresh rate and blur"]="adb shell settings put system peak_refresh_rate 60.0 && adb shell settings put system min_refresh_rate 60.0 && adb shell settings put global disable_window_blurs 1 && adb shell settings put global accessibility_reduce_transparency 1"
    ["Enable fixed performance mode, OverClock"]="adb shell cmd power set-fixed-performance-mode-enabled true"
    ["Disable RAM Plus"]="adb shell settings put global zram_enabled 0 && adb shell settings put global ram_expand_size_list 0"
    ["Improve audio"]="adb shell settings put system k2hd_effect 1 && adb shell settings put system tube_amp_effect 1"
    ["Adjust ring times"]="adb shell settings put secure long_press_timeout 250 && adb shell settings put secure multi_press_timeout 250 && adb shell settings put secure tap_duration_threshold 0.0 && adb shell settings put secure touch_blocking_period 0.0"
    ["Disable Private DNS"]="adb shell settings put global private_dns_mode off"
    ["Improve network performance"]="adb shell settings put global wifi_power_save 0 && adb shell settings put global enable_cellular_on_boot 1 && adb shell settings put global mobile_data_always_on 0 && adb shell settings put global tether_offload_disabled 0 && adb shell settings put global ble_scan_always_enabled 0 && adb shell settings put global network_scoring_ui_enabled 0 && adb shell settings put global network_recommendations_enabled 0"
    ["Adjust power management"]="adb shell settings put system intelligent_sleep_mode 0 && adb shell settings put secure adaptive_sleep 0 && adb shell settings put global app_restriction_enabled true && adb shell settings put global automatic_power_save_mode 0 && adb shell settings put global sem_enhanced_cpu_responsiveness 0 && adb shell settings put global adaptive_battery_management_enabled 0"
)

echo "Welcome to Phone Optimizer!"

# Loop to execute commands
for key in "${!commands[@]}"; do
    read -p "Do you want ${key}? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Running: ${key}..."
        eval "${commands[$key]}"
        echo "Completed!"
    else
        echo "Ignored: ${key}."
    fi
done

# Question to revert settings
read -p "Want to revert the settings to defaults? (y/n): " revert
if [[ "$revert" == "y" || "$revert" == "Y" ]]; then
    revert_commands
else
    echo "Current settings maintained."
fi

echo "Optimization complete!"
