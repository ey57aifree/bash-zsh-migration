# Bash to Zsh Migration Tool / Bash 到 Zsh 遷移工具

**Complete automation script for migrating bash configuration to zsh.**

**完整的自動化腳本，用於將 bash 設定遷移到 zsh。**

---

## 🌐 Language Selection / 語言選擇

| Language | Link |
|----------|------|
<<<<<<< HEAD
| 🇬   **English** | [Read English README](#english-readme) |
| 🇹🇼 **繁體中文** | [閱讀繁體中文說明](#traditional-chinese-readme) |
=======
|   **English** | [Read English README](#english-readme) |
|   **繁體中文** | [閱讀 🇹🇼繁體中文說明](#traditional-chinese-readme) |
>>>>>>> 3317771edc468fe3256c22acbe63264148d113d5

---

## 🚀 Quick Start / 快速開始

```bash
git clone https://github.com/ey57aifree/bash-zsh-migration.git
cd bash-zsh-migration
./migrate-bash-to-zsh.sh
exec zsh
```

---

<a name="english-readme"></a>

## 📖 English README

---

### Features

- **PATH Migration** - Migrate all PATH exports from `.bashrc` and `.bash_profile`
- **Environment Variables** - Migrate LANG, LC_, EDITOR, VISUAL, TERM settings
- **Aliases** - Migrate all bash aliases
- **History Merge** - Merge bash history into zsh history (deduplicated)
- **Zsh Options** - Auto-configure recommended zsh options
- **Backup** - Automatic timestamped backup of existing `.zshrc`
- **Idempotent** - Safe to run multiple times (skips duplicates)
- **Colored Output** - Clear visual feedback with statistics

### Migration Content

| Source File | What Gets Migrated |
|-------------|-------------------|
| `~/.bashrc` | PATH, environment variables, aliases |
| `~/.bash_profile` | PATH, environment variables, aliases |
| `~/.bash_history` | Merged into `~/.zsh_history` |

### Example Output

```
========================================
   bash → zsh Migration Tool
========================================

📖 Processing ~/.bashrc...
  → PATH settings...
    + export PATH="$HOME/.local/bin:$PATH"
  → Aliases...
    + alias ll="ls -la"

📚 Merging history...
✓ Merged bash history

⚙️  Setting up zsh options...
✓ Zsh options configured

========================================
✅ Migration complete!

Statistics:
  • Migrated: 15 items
  • Skipped (duplicates): 2 items

Next steps:
  1. Review ~/.zshrc content
  2. Run: source ~/.zshrc
  3. Or restart terminal
```

### Zsh Options Configured

```bash
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS

# Completion
setopt AUTO_MENU AUTO_LIST COMPLETE_IN_WORD MENU_COMPLETE

# Quality of Life
setopt NO_BEep AUTO_PUSHD PUSHD_IGNORE_DUPS CDABLE_VARS AUTO_CD
setopt GLOB_COMPLETE HASH_LIST_ALL LIST_TYPES
```

### Recommendations After Migration

#### 1. Install a zsh framework

**Oh My Zsh (Full-featured):**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Zinit (Lightweight):**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/zinit-across-os.sh)"
```

#### 2. Install recommended plugins

- **zsh-autosuggestions** - Autocomplete from history
- **zsh-syntax-highlighting** - Syntax highlighting

#### 3. Verify migration

```bash
which <your-command>  # Check PATH
alias                 # Check aliases
echo $PATH            # Check PATH content
```

### FAQ

**Q: Why can't some commands be found after running the script?**  
A: Run `source ~/.zshrc` to reload settings, or restart your terminal.

**Q: Can I safely run this script multiple times?**  
A: Yes! The script is idempotent - it will skip existing settings.

**Q: What if I don't want to migrate certain settings?**  
A: After running the script, manually edit `~/.zshrc` to remove unwanted entries.

**Q: Where are backup files stored?**  
A: Backup files are named `~/.zshrc.bak.YYYYMMDD_HHMMSS` in your home directory.

---

<a name="traditional-chinese-readme"></a>

## 📖 繁體中文說明

---

### 功能特色

- **PATH 遷移** - 從 `.bashrc` 和 `.bash_profile` 遷移所有 PATH 設定
- **環境變數** - 遷移 LANG、LC_、EDITOR、VISUAL、TERM 等設定
- **別名（Aliases）** - 遷移所有 bash 別名
- **歷史記錄合併** - 將 bash 歷史記錄合併到 zsh 歷史記錄（自動去重）
- **Zsh 選項設定** - 自動配置推薦的 zsh 選項
- **自動備份** - 為現有的 `.zshrc` 建立時間戳記備份
- **冪等設計** - 可安全重複執行（跳過重複項目）
- **彩色輸出** - 清晰的視覺反饋與統計資訊

### 遷移內容

| 來源檔案 | 遷移內容 |
|----------|----------|
| `~/.bashrc` | PATH、環境變數、別名 |
| `~/.bash_profile` | PATH、環境變數、別名 |
| `~/.bash_history` | 合併到 `~/.zsh_history` |

### 執行範例

```
========================================
   bash → zsh Migration Tool
========================================

📖 Processing ~/.bashrc...
  → PATH settings...
    + export PATH="$HOME/.local/bin:$PATH"
  → Environment variables...
    + export LANG="zh_TW.UTF-8"
  → Aliases...
    + alias ll="ls -la"
    + alias gs="git status"

📚 Merging history...
✓ Merged bash history

⚙️  Setting up zsh options...
✓ Zsh options configured

========================================
✅ Migration complete!

Statistics:
  • Migrated: 15 items
  • Skipped (duplicates): 2 items

Next steps:
  1. Review ~/.zshrc content
  2. Run: source ~/.zshrc
  3. Or restart terminal
```

### 自動配置的 Zsh 選項

```bash
# 歷史記錄設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS

# 自動補完成
setopt AUTO_MENU AUTO_LIST COMPLETE_IN_WORD MENU_COMPLETE

# 使用體驗
setopt NO_BEep AUTO_PUSHD PUSHD_IGNORE_DUPS CDABLE_VARS AUTO_CD
setopt GLOB_COMPLETE HASH_LIST_ALL LIST_TYPES
```

### 遷移後的建議設定

#### 1. 安裝 Zsh 框架

**Oh My Zsh（功能完整）：**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Zinit（輕量級）：**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/zinit-across-os.sh)"
```

#### 2. 安裝推薦外掛

- **zsh-autosuggestions** - 根據歷史記錄自動建議命令
- **zsh-syntax-highlighting** - 命令語法高亮顯示

#### 3. 驗證遷移結果

```bash
which <你的命令>    # 檢查 PATH 是否正確
alias              # 檢查別名是否遷移成功
echo $PATH         # 檢視 PATH 內容
```

### 常見問題

**Q: 為什麼執行腳本後某些命令還是找不到？**  
A: 請執行 `source ~/.zshrc` 重新載入設定，或重新啟動終端機。

**Q: 可以安全重複執行這個腳本嗎？**  
A: 可以！腳本採用冪等設計，重複執行會自動跳過已存在的設定。

**Q: 如果我不想遷移某些設定怎麼辦？**  
A: 執行腳本後，手動編輯 `~/.zshrc` 移除不需要的項目即可。

**Q: 備份檔案存在哪裡？**  
A: 備份檔案命名為 `~/.zshrc.bak.YYYYMMDD_HHMMSS`，存在主目錄中。

---

## 📄 License

MIT License
