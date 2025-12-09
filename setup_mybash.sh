#!/bin/bash

# --- VARIABLES ---
MYBASH_DIR="$HOME/mybash"
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)

echo "Starting MyBash Setup..."

# 1. Create Directories
echo "[-] Creating directories..."
mkdir -p "$MYBASH_DIR"
mkdir -p "$HOME/.config/fastfetch" # Ensures .config AND .config/fastfetch exist

# 2. Download Files (Curl)
echo "[-] Downloading configuration files..."

# .bashrc (ChrisTitusTech)
curl -sL -o "$MYBASH_DIR/.bashrc" https://raw.githubusercontent.com/ChrisTitusTech/mybash/main/.bashrc
echo "    -> .bashrc downloaded"

# starship.toml (ChrisTitusTech)
curl -sL -o "$MYBASH_DIR/starship.toml" https://raw.githubusercontent.com/ChrisTitusTech/mybash/main/starship.toml
echo "    -> starship.toml downloaded"

# fastfetch config (Dacrab)
curl -sL -o "$MYBASH_DIR/config.jsonc" https://raw.githubusercontent.com/dacrab/fastfetch-config/main/config.jsonc
echo "    -> fastfetch config downloaded"

# 3. Create Symlinks (Backing up old ones first)
echo "[-] Linking files to system..."

# Function to backup and link
link_file() {
    local src=$1
    local dest=$2

    # Check if destination exists (file or symlink)
    if [ -f "$dest" ] || [ -L "$dest" ]; then
        mv "$dest" "${dest}.bak_${BACKUP_DATE}"
        echo "    -> Backed up existing $(basename "$dest")"
    fi
    
    ln -sf "$src" "$dest"
    echo "    -> Linked $(basename "$dest")"
}

link_file "$MYBASH_DIR/.bashrc" "$HOME/.bashrc"
link_file "$MYBASH_DIR/starship.toml" "$HOME/.config/starship.toml"
link_file "$MYBASH_DIR/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "------------------------------------------------"
echo "Setup Complete!"
echo "Action Items:"
echo "1. Run 'nano ~/mybash/.bashrc' and remove any lines that points to missing files/sources."
echo "2. Run 'source ~/.bashrc' to apply changes."
echo "------------------------------------------------"