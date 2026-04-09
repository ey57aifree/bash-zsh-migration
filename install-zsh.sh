#!/bin/bash
# install-zsh.sh - Standalone Zsh installation script
# Usage: ./install-zsh.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}      Zsh Installation Helper${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

print_info() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

install_zsh() {
    echo -e "${BLUE}📦 Detecting package manager...${NC}"
    
    if command -v apt &>/dev/null; then
        echo "  Using apt (Debian/Ubuntu)..."
        sudo -S -p '' apt update && sudo -S -p '' apt install -y zsh
    elif command -v dnf &>/dev/null; then
        echo "  Using dnf (Fedora/CentOS)..."
        sudo -S -p '' dnf install -y zsh
    elif command -v yum &>/dev/null; then
        echo "  Using yum (CentOS/RHEL)..."
        sudo -S -p '' yum install -y zsh
    elif command -v pacman &>/dev/null; then
        echo "  Using pacman (Arch Linux)..."
        sudo -S -p '' pacman -S --noconfirm zsh
    elif command -v brew &>/dev/null; then
        echo "  Using Homebrew (macOS)..."
        brew install zsh
    else
        print_error "Unsupported package manager. Please install zsh manually."
        return 1
    fi
    
    print_info "Zsh installed successfully!"
    return 0
}

main() {
    print_header
    
    if command -v zsh &>/dev/null; then
        echo -e "${YELLOW}Zsh is already installed: $(zsh --version | head -n1)${NC}"
        echo "You can skip this step and proceed to migration."
        exit 0
    fi
    
    if install_zsh; then
        echo ""
        echo -e "${GREEN}Next step: Run the migration script${NC}"
        echo -e "  ${BLUE}./migrate-bash-to-zsh.sh${NC}"
    else
        print_error "Installation failed."
        exit 1
    fi
}

main "$@"
