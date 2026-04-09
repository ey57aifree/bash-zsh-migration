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
    
    echo -e "${CYAN}Welcome! Please choose an option to proceed:${NC}"
    echo ""
    echo -e "${GREEN}1)${NC} Install Zsh only"
    echo -e "${GREEN}2)${NC} Migrate from Bash to Zsh only"
    echo -e "${GREEN}3)${NC} Complete Setup (Install + Migrate)"
    echo -e "${GREEN}q)${NC} Quit"
    echo ""
    
    read -r -p "Enter your choice [1-3/q]: " choice
    echo ""

    case $choice in
        1)
            echo -e "${BLUE}→ Starting Zsh installation...${NC}"
            ./install-zsh.sh
            ;;
        2)
            echo -e "${BLUE}→ Starting migration from Bash to Zsh...${NC}"
            ./migrate-bash-to-zsh.sh
            ;;
        3)
            echo -e "${BLUE}→ Starting complete setup process...${NC}"
            echo -e "${CYAN}Step 1: Installing Zsh...${NC}"
            ./install-zsh.sh
            echo ""
            echo -e "${CYAN}Step 2: Migrating settings...${NC}"
            ./migrate-bash-to-zsh.sh
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
    echo -e "To apply changes, run: ${CYAN}exec zsh${NC}"
}

main "$@"
