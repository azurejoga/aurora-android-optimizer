#!/bin/bash

# Check if the system.txt file exists
if [[ -f "system.txt" ]]; then
    # Read the system saved in the file
    SYSTEM=$(cat system.txt)
else
    # Display operating system selection menu
    clear
    echo "==============================================="
    echo "      Aurora Android Optimizer - OS Selection  "
    echo "==============================================="
    echo
    echo "Choose your operating system:"
    echo "1. Android"
    echo "2. Linux"
    echo -n "Type option (1/2) or press Enter to continue (Windows): "
    read -r os_choice

    if [[ -z "$os_choice" ]]; then
        echo "Windows system detected. Continuing execution..."
        SYSTEM="windows"
    else
        case $os_choice in
            1)
                SYSTEM="android"
                ;;
            2)
                SYSTEM="linux"
                ;;
            *)
                echo "Invalid option! Leaving..."
                exit 1
                ;;
        esac
    fi

    # Save the choice in the system.txt file
    echo "$SYSTEM" > system.txt
fi

# Main menu
clear
echo "==============================================="
echo "         Aurora Android Optimizer v1.0         "
echo "            Developed by AzureJoga             "
echo " GitHub: https://github.com/azurejoga/aurora-android-optimizer "
echo "==============================================="
echo
echo "⚠️ NOTICE IMPORTANT ⚠️"
echo "This program makes modifications to the system of your Android device."
echo "YOU are solely responsible for the changes made."
echo "Backup your device before use!"
echo
echo "Available options:"
echo "1. Remove pre-installed apps and bloatware"
echo "2. Generate list of installed packages (saved in remaining_packages.txt)"
echo "3. Optimize Battery (Any Phone)"
echo "4. Optimize performance (Any phone)"
echo "0. Exit"
echo

generate_package_list() {
    echo "Generating list of installed packages..."
    adb shell 'pm list packages -s' | sed -r 's/package://g' | sort > remaining_packages.txt
    if [[ $? -eq 0 ]]; then
        echo "List generated successfully and saved in remaining_packages.txt!"
    else
        echo "Error generating the list. Make sure ADB is working properly."
    fi
}

show_menu() {
    echo -n "Choose an option: "
    read -r option
    case $option in
        1)
            echo "You chose: Remove bloatware"
            echo "Choose your cell phone brand:"
            echo "1. Samsung"
            echo -n "Enter the brand number: "
            read -r brand_choice
            case $brand_choice in
                1)
                    if [[ -f "./samsung.sh" ]]; then
                        source ./samsung.sh
                    else
                        echo "Error: The file samsung.sh was not found!"
                    fi
                    ;;
                *)
                    echo "Brand not supported yet!"
                    ;;
            esac
            ;;
        2)
            generate_package_list
            ;;
        3)
            echo "You chose: Optimize battery"
            if [[ -f "./optimize-battery.sh" ]]; then
                source ./optimize-battery.sh
            else
                echo "Error: The file optimize-battery.sh was not found!"
            fi
            ;;
        4)
            echo "You chose: Optimize performance"
            if [[ -f "./optimize-phone.sh" ]]; then
                source ./optimize-phone.sh
            else
                echo "Error: The file optimize-phone.sh was not found!"
            fi
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option! Please try again."
            ;;
    esac
}

# Windows-specific logic
if [[ "$SYSTEM" == "windows" ]]; then
    echo "System detected as Windows. Proceeding with execution..."
fi

# Loop for Linux/Android menu
while true; do
    show_menu
done
