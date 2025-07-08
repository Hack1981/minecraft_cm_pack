#!/bin/bash

set -e  # Encerra o script se algum comando falhar

echo "==> Atualizando o sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando drivers de vídeo Intel e ferramentas necessárias..."
sudo pacman -S --noconfirm \
  xf86-video-intel \
  mesa \
  intel-ucode \
  python \
  python-pip \
  tk \
  unzip \
  wget

echo "==> Verificando versões do Python e pip..."
python3 --version
pip3 --version

echo "==> Instalando bibliotecas Python..."
pip3 install --break-system-packages customtkinter

# Define variáveis
ZIP_FILE="minecraft_cm_pack.zip"
EXTRACT_DIR="extracted_pack"

echo "==> Verificando se o arquivo $ZIP_FILE está presente..."
if [[ ! -f "$ZIP_FILE" ]]; then
  echo "❌ Arquivo $ZIP_FILE não encontrado no diretório atual."
  exit 1
fi

echo "==> Extraindo $ZIP_FILE para $EXTRACT_DIR..."
unzip "$ZIP_FILE" -d "$EXTRACT_DIR"

cd "$EXTRACT_DIR"/* || exit 1
echo "==> Entrou na pasta extraída: $(pwd)"

# Executa o bash.sh se existir
if [[ -f "bash.sh" ]]; then
  echo "==> Executando bash.sh da pasta extraída..."
  chmod +x bash.sh
  ./bash.sh
else
  echo "⚠️  Arquivo bash.sh não encontrado na pasta extraída."
fi
