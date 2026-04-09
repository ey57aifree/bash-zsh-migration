# Zsh Install & Migrate / Zsh 安裝與遷移工具

**The complete automation suite for onboarding into Zsh. From installation and Bash configuration migration to essential plugin setup.**

**一套完整的 Zsh 部署自動化套件。涵蓋了從安裝 Zsh、遷移 Bash 設定到配置核心外掛的全過程。**

---

## 🌐 Language Selection / 語言選擇

| Language | Link |
|----------|------|
|   **English** | [Read English README](#english-readme) |
|   **繁體中文** | [閱讀 🇹🇼繁體中文說明](#traditional-chinese-readme) |

---

## 🚀 Quick Start / 快速開始

```bash
# 1. Clone the repository
git clone https://github.com/ey57aifree/zsh-install-and-migrate.git
cd zsh-install-and-migrate

# 2. Run the interactive setup wizard
./setup.sh

# 3. Apply changes and enter Zsh
exec zsh
```

---

<a name="english-readme"></a>

## 📖 English README

### 🌟 Overview
This tool simplifies the transition from Bash to Zsh. Instead of manually copying configs and hunting for plugin installation guides, `setup.sh` provides an interactive menu to customize your deployment.

### 🛠️ Interactive Menu Options
When you run `./setup.sh`, you can choose from the following paths:

| Option | Name | Description |
|---|---|---|
| **1** | **Pure Install Zsh** | Installs Zsh using your system's package manager. |
| **2** | **Install + Migrate** | Installs Zsh AND migrates your `.bashrc` / `.bash_profile` settings. |
| **3** | **Ultimate Setup** | **(Recommended)** Full pipeline: Install $\rightarrow$ Migrate $\rightarrow$ Setup Plugins. |
| **4** | **Pure Plugin Install** | Installs recommended plugins (checks for Zsh installation first). |

### 🔌 Installed Plugins
The "Ultimate Setup" or "Plugin Install" options will automatically configure:
- **`zsh-autosuggestions`**: Suggests commands based on your history as you type.
- **`zsh-syntax-highlighting`**: Provides real-time visual feedback on command correctness.

### 🔑 Default Shell
The migration script will ask if you want to set Zsh as your **default shell** (`chsh`). 
**Important**: If you accept, you must log out and log back in (or restart your SSH session) for the change to take effect.

---

<a name="traditional-chinese-readme"></a>

## 📖 繁體中文說明

### 🌟 專案簡介
本工具旨在簡化從 Bash 遷移到 Zsh 的過程。你不再需要手動複製設定檔或搜尋外掛安裝教學，透過 `setup.sh` 的互動式選單，即可快速完成所有部署。

### 🛠️ 互動式選單說明
執行 `./setup.sh` 後，你可以根據需求選擇不同的路徑：

| 選項 | 名稱 | 說明 |
|---|---|---|
| **1** | **僅安裝 Zsh** | 使用系統套件管理器安裝 Zsh。 |
| **2** | **安裝 + 遷移** | 安裝 Zsh 並將 `.bashrc` / `.bash_profile` 的設定遷移至 Zsh。 |
| **3** | **終極全安裝** | **(推薦)** 完整流程：安裝 $\rightarrow$ 遷移 $\rightarrow$ 配置外掛。 |
| **4** | **僅安裝外掛** | 安裝推薦外掛（會先行檢查 Zsh 是否已安裝）。 |

### 🔌 內建推薦外掛
選擇「終極全安裝」或「僅安裝外掛」將會自動配置：
- **`zsh-autosuggestions`**：根據歷史記錄在輸入時提供智能建議。
- **`zsh-syntax-highlighting`**：對指令進行即時顯色，讓你知道指令是否正確。

### 🔑 預設 Shell 設定
遷移過程中，腳本會詢問你是否要將 Zsh 設為**系統預設 Shell** (`chsh`)。
**重要提示**：若選擇同意，你必須 **登出並重新登入**（或重新開啟 SSH 連線），預設 Shell 的變更才會生效。

### 📝 遷移內容
- **PATH 遷移**：從 Bash 設定檔提取所有 PATH exports。
- **環境變數**：遷移 LANG, LC_, EDITOR 等重要設定。
- **別名 (Aliases)**：遷移所有 bash aliases。
- **歷史記錄**：將 `.bash_history` 合併至 `.zsh_history` 並去重。

---

## 📄 License
MIT License
