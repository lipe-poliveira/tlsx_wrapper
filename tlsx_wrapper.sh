#!/bin/bash

# Nome: tlsx_wrapper.sh
# Descrição: Script para rodar tlsx em modo -u ou -l, com verificação de dependências

# Arquivo de saída
OUTPUT="resultados.txt"

# Função para verificar se um comando existe
check_command() {
    if ! command -v "$1" &> /dev/null; then
        return 1
    fi
    return 0
}

# Função para instalar ferramentas Go
install_go_tool() {
    TOOL=$1
    echo "[*] Instalando $TOOL via go install..."
    go install github.com/projectdiscovery/${TOOL}/cmd/${TOOL}@latest
    cp "$(go env GOPATH)/bin/$TOOL" /usr/local/bin/ 2>/dev/null || sudo cp "$(go env GOPATH)/bin/$TOOL" /usr/local/bin/
    echo "[+] $TOOL instalado em /usr/local/bin/"
}

# Verificação do Go
if ! check_command go; then
    echo "[-] Go não está instalado. Por favor, instale o Go antes de continuar."
    exit 1
fi

# Verificação e instalação das ferramentas
for tool in tlsx anew; do
    if ! check_command "$tool"; then
        read -p "[?] $tool não encontrado. Deseja instalar? (s/n): " resp
        if [[ "$resp" == "s" ]]; then
            install_go_tool "$tool"
        else
            echo "[-] $tool é necessário. Abortando."
            exit 1
        fi
    fi
done

# Verificação do jq
if ! check_command jq; then
    read -p "[?] jq não encontrado. Deseja instalar? (s/n): " resp
    if [[ "$resp" == "s" ]]; then
        sudo apt update && sudo apt install -y jq
    else
        echo "[-] jq é necessário. Abortando."
        exit 1
    fi
fi

# Processamento de argumentos
while getopts "u:l:" opt; do
    case $opt in
        u)
            url=$OPTARG
            echo "[*] Processando URL: $url"
            echo "$url" | tlsx -json -silent | jq -r '.subject_an[]?' | anew "$OUTPUT"
            ;;
        l)
            list=$OPTARG
            if [ ! -f "$list" ]; then
                echo "[-] Arquivo $list não encontrado!"
                exit 1
            fi
            echo "[*] Processando lista de subdomínios: $list"
            cat "$list" | xargs -n1 -I{} sh -c 'echo "{}" | tlsx -json -silent' | jq -r '.subject_an[]?' | anew "$OUTPUT"
            ;;
        *)
            echo "Uso: $0 -u <url> | -l <arquivo_de_subdominios>"
            exit 1
            ;;
    esac
done

echo "[+] Resultados salvos em $OUTPUT"
