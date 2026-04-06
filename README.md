# Bash to Zsh Migration Tool

Complete automation script for migrating bash configuration to zsh.

## Features

- **PATH Migration** - Migrate all PATH exports from `.bashrc` and `.bash_profile`
- **Environment Variables** - Migrate LANG, LC_, EDITOR, VISUAL, TERM settings
- **Aliases** - Migrate all bash aliases
- **History Merge** - Merge bash history into zsh history (deduplicated)
- **Zsh Options** - Auto-configure recommended zsh options
- **Backup** - Automatic timestamped backup of existing `.zshrc`
- **Idempotent** - Safe to run multiple times (skips duplicates)
- **Colored Output** - Clear visual feedback with statistics

## Usage

```bash
./migrate-bash-to-zsh.sh
```

## Example Output

```
========================================
   bash → zsh Migration Tool
========================================

📖 Processing ~/.bashrc...
  → PATH settings...
    + export PATH="$HOME/.local/bin:$PATH"
  → Aliases...
    + alias ll="ls -la"

✅ Migration complete!
  • Migrated: 15 items
  • Skipped: 2 items
```

## Next Steps

1. Review ~/.zshrc content
2. Run: source ~/.zshrc
3. Install zsh-autosuggestions and zsh-syntax-highlighting

## License

MIT
