#!/bin/bash
# setup.sh - Interactive Zsh Setup & Migration Wizard
# Usage: ./setup.sh

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}    🚀 Zsh Install & Migrate Wizard${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

main() {
    print_header
    
    echo -e "${CYAN}Welcome! Please choose your setup goal:${NC}"
    echo ""
    echo -e "${GREEN}1)${NC} Pure Install Zsh (僅安裝 Zsh)"
    echo -e "${GREEN}2)${NC} Install Zsh + Migrate from Bash (安裝 Zsh + 遷移設定)"
    echo -e "${GREEN}3)${NC} Ultimate Setup (安裝 Zsh + 遷移設定 + 安裝外掛)"
    echo -e "${GREEN}4)${NC} Pure Plugin Install (僅安裝外掛 - 會檢查 Zsh 是否存在)"
    echo -e "${GREEN}q)${NC} Quit"
    echo ""
    
    read -r -p "Enter your choice [1-4/q]: " choice
    echo ""

    case $choice in
        1)
            echo -e "${BLUE}→ Path: Install Zsh only${NC}"
            ./install-zsh.sh
            ;;
        2)
            echo -e "${BLUE}→ Path: Install Zsh + Migrate settings${NC}"
            ./install-zsh.sh
            echo ""
            ./migrate-bash-to-zsh.sh
            ;;
        3)
            echo -e "${BLUE}→ Path: Ultimate Setup (Full Experience)${NC}"
            echo -e "${CYAN}Step 1: Installing Zsh...${NC}"
            ./install-zsh.sh
            echo ""
            echo -e "${CYAN}Step 2: Migrating settings...${NC}"
            ./migrate-bash-to-zsh.sh
            echo ""
            echo -e "${CYAN}Step 3: Installing recommended plugins...${NC}"
            ./install-plugins.sh
            ;;
        4)
            echo -e "${BLUE}→ Path: Installing plugins only${NC}"
            ./install-plugins.sh
            ;;
        q|Q)
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please run ./setup.sh again.${NC}"
            exit 1
            ;;
    esac

    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}🎉 Process completed successfully!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "To apply all changes, run: ${CYAN}exec zsh${NC}"
}

main "$@"
