#!/bin/bash
# install-plugins.sh - Install recommended Zsh plugins
# Usage: ./install-plugins.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PLUGIN_DIR="$HOME/.zsh/plugins"
ZSHRC="$HOME/.zshrc"

print_info() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

check_zsh() {
    if ! command -v zsh &>/dev/null; then
        print_error "Zsh is not installed. Please install Zsh first using ./setup.sh"
        return 1
    fi
    return 0
}

install_plugin() {
    local name="$1"
    local repo="$2"
    local script="$3"
    local target_dir="$PLUGIN_DIR/$name"
    
    echo -e "${BLUE}📦 Installing $name...${NC}"
    
    if [[ -d "$target_dir" ]]; then
        echo "  Plugin directory already exists, skipping clone..."
    else
        /bin/mkdir -p "$PLUGIN_DIR"
        if ! git clone "$repo" "$target_dir"; then
            print_error "Failed to clone $name"
            return 1
        fi
    fi
    
    local source_line="source $target_dir/$script"
    if ! grep -qF "$source_line" "$ZSHRC" 2>/dev/null; then
        echo "$source_line" >> "$ZSHRC"
        print_info "$name configured in ~/.zshrc"
    else
        echo "  $name is already configured in ~/.zshrc"
    fi
}

main() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}    🔌 Zsh Plugin Installer${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""

    if ! check_zsh; then exit 1; fi

    # 1. zsh-autosuggestions
    install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
    
    # 2. zsh-syntax-highlighting (MUST be last)
    install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"

    echo ""
    print_info "All plugins installed successfully!"
    echo -e "Run ${CYAN}source ~/.zshrc${NC} to activate."
}

main "$@"
