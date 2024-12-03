#!/bin/bash

# Lista de comandos com descrições
commands=(
    "background_process_limit:Limitar processos em segundo plano para 1"
    "cached_apps_freezer:Habilitar suspensão para apps em cache"
    "always_finish_activities:Fechar atividades ao sair"
    "ram_plus_feature_enabled:Desativar RAM+"
    "app_hibernation_enabled:Habilitar hibernação de aplicativos"
    "adaptive_battery_management_enabled:Habilitar gerenciamento de bateria adaptável"
    "wifi_scan_always_enabled:Desativar varredura de Wi-Fi constante"
    "ble_scan_always_enabled:Desativar varredura de Bluetooth constante"
    "location_accuracy_enabled:Desativar precisão de localização do Google"
    "usage_reporting_enabled:Desativar envio de dados e diagnósticos"
    "auto_update_apps:Desativar atualizações automáticas da Play Store"
    "wifi_scan_throttle_enabled:Habilitar limitação de varredura de Wi-Fi"
    "preferred_network_mode:Forçar uso de rede 4G em vez de 5G"
    "auto_sync:Desativar sincronização automática"
    "double_tap_to_wake:Desativar toque duplo para ativar tela"
    "screen_brightness_mode:Habilitar brilho adaptável"
    "screen_resolution:Reduzir resolução da tela"
    "screen_density:Ajustar densidade da tela"
    "disable_wellbeing:Desativar o Bem-Estar Digital"
)

# Função para aplicar comandos individualmente
apply_command() {
    key=$1
    value=$2
    description=$3

    echo "Deseja aplicar a configuração: $description? (y/n)"
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
        echo "Configuração aplicada: $description"
    else
        echo "Configuração ignorada: $description"
    fi
}

# Função para restaurar configurações
revert_commands() {
    echo "Revertendo configurações para os padrões..."
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
    echo "Configurações revertidas para os padrões!"
}

# Perguntar ao usuário se deseja restaurar as configurações padrão antes de continuar
echo "Deseja restaurar as configurações padrão de otimização de bateria antes de continuar? (y/n/c)"
read -r reset_choice

if [[ $reset_choice == "y" || $reset_choice == "Y" ]]; then
    revert_commands
elif [[ $reset_choice == "c" || $reset_choice == "C" ]]; then
    echo "Continuando sem restaurar configurações padrão..."
fi

# Aplicar comandos um por um
for cmd in "${commands[@]}"; do
    key=$(echo "$cmd" | cut -d':' -f1)
    description=$(echo "$cmd" | cut -d':' -f2)

    if [[ $key == "screen_resolution" || $key == "screen_density" ]]; then
        apply_command "$key" "" "$description"
    else
        apply_command "$key" 1 "$description"
    fi
done

echo "Todas as configurações foram processadas!"
