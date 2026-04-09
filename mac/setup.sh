#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing packages..."
brew bundle --file="$DIR/Brewfile"

echo "==> Applying macOS defaults..."
bash "$DIR/defaults.sh"

echo "==> Setting up Rust toolchain..."
rustup default stable
rustup component add clippy rust-analyzer

echo "==> Done! Open a new terminal and run:"
echo "    fnm install --lts && npm install -g @anthropic-ai/claude-code"
