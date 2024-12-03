#!/bin/bash

# Exibindo informações do programa e desenvolvedor
clear
echo "==============================================="
echo "         Aurora Android Optimizer v1.0         "
echo "          Developed by AzureJoga              "
echo "      GitHub: https://github.com/azurejoga    "
echo "==============================================="
echo
echo "⚠️ AVISO IMPORTANTE ⚠️"
echo "Este programa realiza modificações no sistema do seu dispositivo Android."
echo "VOCÊ é o único responsável pelas alterações realizadas."
echo "Faça backup do seu dispositivo antes de usar!"
echo "Se você não tem certeza do que está fazendo, NÃO utilize este programa."
echo
echo "Este programa requer que o ADB esteja instalado no seu sistema."
echo "Certifique-se de que a depuração USB esteja ativada no seu dispositivo Android."
echo
echo "Opções disponíveis:"
echo "1. Remover aplicativos pré-instalados e bloatwares"
echo "2. Gerar lista de pacotes instalados (salvo em remaining_packages.txt)"
echo "3. Otimizar bateria (Qualquer telefone)"
echo "4. Otimizar desempenho (Qualquer telefone)"
echo "0. Sair"
echo

# Função para gerar lista de pacotes instalados
generate_package_list() {
    echo "Gerando lista de pacotes instalados..."
    adb shell 'pm list packages -s' | sed -r 's/package://g' | sort > remaining_packages.txt
    if [[ $? -eq 0 ]]; then
        echo "Lista gerada com sucesso e salva em remaining_packages.txt!"
    else
        echo "Erro ao gerar a lista. Certifique-se de que o ADB está funcionando corretamente."
    fi
}

# Função para exibir o menu e processar a escolha do usuário
show_menu() {
    echo -n "Escolha uma opção: "
    read -r option
    case $option in
        1)
            echo "Você escolheu: Remover bloatwares"
            echo "Escolha a marca do seu celular:"
            echo "1. Samsung"
            echo -n "Digite o número da marca: "
            read -r brand_choice
            case $brand_choice in
                1)
                    # Chama o script para a marca Samsung
                    source ./samsung.sh
                    ;;
                *)
                    echo "Marca não suportada ainda!"
                    ;;
            esac
            ;;
        2)
            generate_package_list
            ;;
        3)
            echo "Você escolheu: Otimizar bateria"
            if [[ -f "./optimize-battery.sh" ]]; then
                source ./optimize-battery.sh
            else
                echo "Erro: O arquivo optimize-battery.sh não foi encontrado!"
            fi
            ;;
        4)
            echo "Você escolheu: Otimizar desempenho"
            if [[ -f "./optimize-phone.sh" ]]; then
                source ./optimize-phone.sh
            else
                echo "Erro: O arquivo optimize-phone.sh não foi encontrado!"
            fi
            ;;
        0)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida! Tente novamente."
            ;;
    esac
}

# Loop para mostrar o menu até o usuário sair
while true; do
    show_menu
done
