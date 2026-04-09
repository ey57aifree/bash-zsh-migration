#!/bin/bash
# migrate-bash-to-zsh.sh - Complete bash to zsh migration tool
# Usage: ./migrate-bash-to-zsh.sh
#
# This script migrates bash configuration to zsh:
# - PATH and environment variables
# - Aliases
# - Command history
# - Basic zsh options

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# File paths
BASHRC="~/.bashrc"
BASH_PROFILE="~/.bash_profile"
ZSHRC="~/.zshrc"
ZSH_HISTORY="~/.zsh_history"
BASH_HISTORY="~/.bash_history"

# Statistics
MIGRATED_ITEMS=0
SKIPPED_ITEMS=0

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}   bash → zsh Migration Tool${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

print_info() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_step() { echo -e "${CYAN}→${NC} $1"; }

check_file() {
    local file="$1"
    local real_path
    real_path=$(eval echo "$file")
    [[ -f "$real_path" ]]
}

line_exists() {
    local line="$1"
    local file="$2"
    local real_path
    real_path=$(eval echo "$file")
    check_file "$file" && /usr/bin/grep -qF "$line" "$real_path" 2>/dev/null
}

append_if_not_exists() {
    local line="$1"
    local file="$2"
    local real_path
    real_path=$(eval echo "$file")
    
    /bin/mkdir -p "$(dirname "$real_path")" 2>/dev/null
    
    if ! line_exists "$line" "$file"; then
        echo "$line" >> "$real_path"
        ((MIGRATED_ITEMS++))
        return 0
    fi
    ((SKIPPED_ITEMS++))
    return 1
}

install_zsh() {
    echo -e "${BLUE}📦 Installing zsh...${NC}"
    
    if command -v apt &>/dev/null; then
        echo "  Using apt package manager..."
        if ! sudo -S -p '' apt update &>/dev/null; then
            print_warning "Failed to update package list, continuing anyway..."
        fi
        if ! sudo -S -p '' apt install -y zsh &>/dev/null; then
            print_error "Failed to install zsh"
            return 1
        fi
    elif command -v dnf &>/dev/null; then
        echo "  Using dnf package manager..."
        if ! sudo -S -p '' dnf install -y zsh &>/dev/null; then
            print_error "Failed to install zsh"
            return 1
        fi
    elif command -v yum &>/dev/null; then
        echo "  Using yum package manager..."
        if ! sudo -S -p '' yum install -y zsh &>/dev/null; then
            print_error "Failed to install zsh"
            return 1
        fi
    elif command -v pacman &>/dev/null; then
        echo "  Using pacman package manager..."
        if ! sudo -S -p '' pacman -S --noconfirm zsh &>/dev/null; then
            print_error "Failed to install zsh"
            return 1
        fi
    elif command -v brew &>/dev/null; then
        echo "  Using Homebrew..."
        if ! brew install zsh &>/dev/null; then
            print_error "Failed to install zsh"
            return 1
        fi
    else
        print_error "Unsupported package manager. Please install zsh manually."
        return 1
    fi
    
    print_info "Zsh installed successfully!"
    return 0
}

check_zsh_installed() {
    echo -e "${BLUE}🔍 Checking zsh installation...${NC}"
    
    if command -v zsh &>/dev/null; then
        local version
        version=$(zsh --version 2>&1 | /usr/bin/head -n1)
        print_info "Zsh is installed: $version"
        return 0
    else
        print_error "Zsh is NOT installed on your system"
        echo ""
        echo -e "${YELLOW}Would you like to install zsh now? [Y/n]${NC}"
        read -r -p "" response
        
        if [[ "$response" =~ ^[Nn]$ ]]; then
            echo ""
            echo -e "${YELLOW}Installation instructions:${NC}"
            echo ""
            
            if command -v apt &>/dev/null; then
                echo -e "  ${GREEN}sudo -S -p '' apt update && sudo -S -p '' apt install zsh${NC}"
            elif command -v dnf &>/dev/null; then
                echo -e "  ${GREEN}sudo -S -p '' dnf install zsh${NC}"
            elif command -v yum &>/dev/null; then
                echo -e "  ${GREEN}sudo -S -p '' yum install zsh${NC}"
            elif command -v pacman &>/dev/null; then
                echo -e "  ${GREEN}sudo -S -p '' pacman -S zsh${NC}"
            else
                echo "  Please install zsh from your distribution's repository."
            fi
            echo ""
            return 1
        fi
        
        # Auto install
        if install_zsh; then
            return 0
        else
            print_error "Installation failed. Please install zsh manually."
            return 1
        fi
    fi
}

migrate_settings() {
    local source_file="$1"
    local description="$2"
    local real_path
    real_path=$(eval echo "$source_file")
    
    if ! check_file "$source_file"; then
        print_warning "$description ($source_file) not found"
        return
    fi
    
    echo -e "${BLUE}📖 Processing $description...${NC}"
    
    # 1. Import PATH settings
    echo "  → PATH settings..."
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue
        line=$(echo "$line" | /usr/bin/sed 's/;$//')
        if append_if_not_exists "$line" "$ZSHRC"; then
            echo "    + $line"
        fi
    done < <(/usr/bin/grep -E '^export\s+PATH' "$real_path" 2>/dev/null || true)
    
    # 2. Import other environment variables
    echo "  → Environment variables..."
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue
        line=$(echo "$line" | /usr/bin/sed 's/;$//')
        if append_if_not_exists "$line" "$ZSHRC"; then
            echo "    + $line"
        fi
    done < <(/usr/bin/grep -E '^export\s+(LANG|LC_|EDITOR|VISUAL|TERM)' "$real_path" 2>/dev/null | /usr/bin/grep -v PATH || true)
    
    # 3. Import aliases
    echo "  → Aliases..."
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "${line// }" ]] && continue
        line=$(echo "$line" | /usr/bin/sed 's/;$//')
        if append_if_not_exists "$line" "$ZSHRC"; then
            echo "    + $line"
        fi
    done < <(/usr/bin/grep -E '^alias\s+' "$real_path" 2>/dev/null || true)
}

merge_history() {
    echo -e "${BLUE}📚 Merging history...${NC}"
    local bash_hist zsh_hist
    bash_hist=$(eval echo "$BASH_HISTORY")
    zsh_hist=$(eval echo "$ZSH_HISTORY")
    
    if [[ -f "$bash_hist" ]]; then
        if [[ -f "$zsh_hist" ]]; then
            /bin/cat "$bash_hist" "$zsh_hist" | /usr/bin/sort -u > "${zsh_hist}.tmp"
            /bin/mv "${zsh_hist}.tmp" "$zsh_hist"
        else
            /bin/cp "$bash_hist" "$zsh_hist"
        fi
        print_info "Merged bash history"
        ((MIGRATED_ITEMS++))
    else
        print_warning "No bash history found"
    fi
}

setup_zsh_options() {
    echo -e "${BLUE}⚙️  Setting up zsh options...${NC}"
    
    # Add a separator if file has content
    if check_file "$ZSHRC"; then
        echo '' >> "$ZSHRC"
    fi
    
    echo '# ========================================
# Zsh Options (auto-configured by migrate-bash-to-zsh.sh)
# ==========================================' >> "$ZSHRC"
    echo '' >> "$ZSHRC"
    echo '# History settings' >> "$ZSHRC"
    echo 'HISTFILE=~/.zsh_history' >> "$ZSHRC"
    echo 'HISTSIZE=10000' >> "$ZSHRC"
    echo 'SAVEHIST=10000' >> "$ZSHRC"
    echo 'setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY' >> "$ZSHRC"
    echo 'setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS' >> "$ZSHRC"
    echo '' >> "$ZSHRC"
    echo '# Completion settings' >> "$ZSHRC"
    echo 'setopt AUTO_MENU AUTO_LIST COMPLETE_IN_WORD MENU_COMPLETE' >> "$ZSHRC"
    echo '' >> "$ZSHRC"
    echo '# Quality of Life settings' >> "$ZSHRC"
    echo 'setopt NO_BEep AUTO_PUSHD PUSHD_IGNORE_DUPS CDABLE_VARS AUTO_CD' >> "$ZSHRC"
    echo 'setopt GLOB_COMPLETE HASH_LIST_ALL LIST_TYPES' >> "$ZSHRC"
    
    print_info "Zsh options configured"
    ((MIGRATED_ITEMS++))
}

generate_report() {
    echo ""
    print_header
    echo -e "${GREEN}✅ Migration complete!${NC}"
    echo ""
    echo -e "${CYAN}Statistics:${NC}"
    echo "  • Migrated: $MIGRATED_ITEMS items"
    echo "  • Skipped (duplicates): $SKIPPED_ITEMS items"
    echo ""
    echo -e "${CYAN}Next steps:${NC}"
    echo "  1. Review ~/.zshrc content"
    echo "  2. Run: source ~/.zshrc"
    echo "  3. Or restart terminal"
    echo ""
    echo -e "${CYAN}Recommendations:${NC}"
    echo "  • Install oh-my-zsh or zinit"
    echo "  • Install zsh-autosuggestions and zsh-syntax-highlighting"
    echo ""
}

main() {
    print_header
    
    echo "Starting bash to zsh migration..."
    echo ""
    
    # Check if zsh is installed FIRST
    if ! check_zsh_installed; then
        exit 1
    fi
    
    echo ""
    
    # Backup existing zshrc
    local zshrc_real
    zshrc_real=$(eval echo "$ZSHRC")
    if [[ -f "$zshrc_real" ]]; then
        local backup="${zshrc_real}.bak.$(/bin/date +%Y%m%d_%H%M%S)"
        /bin/cp "$zshrc_real" "$backup"
        print_info "Backed up ~/.zshrc → $backup"
    fi
    
    # Migrate settings
    migrate_settings "$BASHRC" "~/.bashrc"
    migrate_settings "$BASH_PROFILE" "~/.bash_profile"
    
    # Merge history
    merge_history
    
    # Setup zsh options
    setup_zsh_options
    
    # Generate report
    generate_report
}

main "$@"
