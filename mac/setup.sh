#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages..."
brew bundle --file="$DIR/Brewfile"

echo "==> Applying macOS defaults..."
bash "$DIR/defaults.sh"

echo "==> Linking shell + terminal configs..."
mkdir -p ~/.config/fish ~/.config/ghostty
ln -sfn "$DIR/config/fish/config.fish" ~/.config/fish/config.fish
ln -sfn "$DIR/config/ghostty/config" ~/.config/ghostty/config
ln -sfn "$DIR/config/starship.toml" ~/.config/starship.toml

echo "==> Installing Catppuccin Mocha fish theme..."
mkdir -p ~/.config/fish/themes
curl -fsSL https://raw.githubusercontent.com/catppuccin/fish/main/themes/catppuccin-mocha.theme \
  -o "$HOME/.config/fish/themes/catppuccin-mocha.theme"
fish -c 'fish_config theme save "Catppuccin Mocha"' || true

echo "==> Setting up Rust toolchain..."
rustup default stable
rustup component add clippy rust-analyzer

echo "==> Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo "==> Installing caveman skill..."
npx -y skills add JuliusBrussee/caveman

echo "==> Setting fish as default shell..."
FISH_PATH="$(command -v fish)"
if ! grep -qx "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$FISH_PATH"

echo "==> Done! Open a new terminal."
