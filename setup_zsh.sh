#!/usr/bin/env bash

# === CONFIG ===
REPO_URL="https://github.com/j3nki/Zsh/raw/main/my_zsh_setup.tar.gz"
TMP_TAR="/tmp/my_zsh_setup.tar.gz"

# === 1. INSTALLA PACCHETTI NECESSARI ===
echo "🔧 Installing dependencies..."
sudo dnf install -y zsh git curl fastfetch tar

# === 2. INSTALLA OH MY ZSH ===
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# === 3. SCARICA IL BACKUP TAR DAL REPO ===
echo "⬇️  Downloading configuration archive..."
curl -L "$REPO_URL" -o "$TMP_TAR"

# === 4. ESTRARLO NELLA HOME ===
echo "📦 Extracting configuration..."
tar -xzf "$TMP_TAR" -C "$HOME"

# === 5. CAMBIA SHELL DI DEFAULT (se serve) ===
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔁 Setting Zsh as default shell..."
  chsh -s "$(which zsh)"
fi

echo "✅ Configuration restored! Start a new terminal to apply changes."
