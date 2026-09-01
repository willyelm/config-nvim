# Neovim Config

My personal setup configured with Neovim's built-in `vim.pack` package manager.
Optimized for web development, TypeScript, Go, Python, scripting, and general
editing with LSP, formatting, git integration, and modern UI enhancements.

## Requirements

- Neovim >= 0.12.0
- Git
- Node.js >= 18
- Ripgrep (`rg`)
- GCC + make (for telescope-fzf-native)

## Installation

```bash
# Clone this config
git clone https://github.com/willyelm/nvim ~/.config/nvim
cd ~/.config/nvim
nvim
```

`vim.pack` will automatically install managed plugins on first launch and track
them in `nvim-pack-lock.json`. Restart Neovim once after the first install pass
so newly added packages are available to `:packadd`.

## LSP & Formatters

This config uses **Neovim's native LSP client** (v0.11+). Install language
servers on your system:

```bash
# Go / Lua / Python
brew install gopls pyright lua-language-server

# TypeScript / Others (as needed)
npm install -g @vtsls/language-server vscode-langservers-extracted yaml-language-server @tailwindcss/language-server @mdx-js/language-server dockerfile-language-server-nodejs @biomejs/biome prettier @fsouza/prettierd

# Go Formatters
go install golang.org/x/tools/cmd/goimports@latest
```

## Tree Sitter

Make sure tree-sitter-cli is installed `npm i -g tree-sitter-cli` and then in neo vim, install if not getting syntax highlight:

```
:TSInstall json typescript tsx go markdown markdown_inline html css javascript yaml toml dockerfile bash sql python
```

## Features

### LSP & Code Intelligence

- **Neovim's native LSP client** (v0.12+) - no external wrappers
- Intelligent code completion with nvim-cmp
- Treesitter syntax highlighting and text objects
- Auto-pairs and auto-tag insertion
- Inline diagnostics with tiny-inline-diagnostic
- Type information inlay hints
- Code actions and symbol renaming

### Code Formatting

- Conform.nvim for automated formatting on save
- Biome for JavaScript/TypeScript/JSON
- Prettier for styling languages
- goimports for Go

### Git Integration

- **Gitsigns** - Inline git indicators and blame
- **Pulse.nvim** - Git history, branches, and stash browsing

### Search & Navigation

- **Pulse.nvim** - Custom fuzzy finder with live grep
- **Grug-far** - Search and replace across files
- **Pulse.nvim** - File finding and open buffer navigation
- **Which-key** - Interactive keybinding hints

### UI & UX

- **NvimTree** - File explorer with git status
- **Lualine** - Statusline with git branch, diagnostics
- **Barbecue** - Breadcrumb navigation bar
- **Scrollbar** - Visual scroll indicator with git/diagnostic marks
- **Nvim-colorizer** - Color preview for CSS/hex values
- **Bufdelete** - Intelligent buffer deletion

### Keyboard Shortcuts

#### Navigation & Search

| Keymap          | Description            |
| --------------- | ---------------------- |
| `<leader>\`     | Toggle file explorer   |
| `<leader>p`     | Pulse menu             |
| `<leader>f`     | Fuzzy search in buffer |
| `<leader>l`     | Live grep              |
| `<leader>u`     | Undo history           |
| `<leader>k`     | Keymaps                |
| `<leader><Tab>` | Next window            |

#### Search & Replace

| Keymap       | Description        |
| ------------ | ------------------ |
| `<leader>sr` | Search and replace |

#### Git

| Keymap       | Description       |
| ------------ | ----------------- |
| `<leader>gd` | Diff current file |
| `<leader>gR` | Reset buffer      |
| `<leader>ga` | Toggle diffview   |
| `<leader>gc` | Commit            |
| `<leader>gz` | Stash             |
| `<leader>gh` | File history      |
| `<leader>gH` | Project history   |
| `<leader>gb` | Branches          |
| `<leader>gB` | Diff branch       |
| `<leader>gs` | Stash menu        |

#### Code & Editing

| Keymap       | Description           |
| ------------ | --------------------- |
| `K`          | Hover documentation   |
| `<leader>i`  | Show diagnostics/docs |
| `<leader>ra` | Code actions          |
| `<leader>rs` | Rename symbol         |
| `<leader>/`  | Toggle comment        |
| `<M-Down>`   | Move line down        |
| `<M-Up>`     | Move line up          |
| `<leader>.`  | Increase indent       |
| `<leader>,`  | Decrease indent       |
| `<leader>c`  | Copy file location    |

# Syncing update with vim.pack

at times vim.pack will keep updates in pending. to get around it clean up lock
files:

```
find ~/.local/share/nvim/site/pack/ -name "index.lock" -delete
```

then run `:lua vim.pack.update()`

# Clean reinstall

If plugin state gets inconsistent (e.g. leftovers from a previous plugin
manager, or stale treesitter queries mixing into the runtimepath), run:

```
./scripts/clean-reinstall.sh
```

It removes old `lazy/`, `pack/packer/`, `mason/` trees and the symlinked query
directory, then you launch `nvim` once to let `vim.pack` and nvim-treesitter
rebuild everything. Your persistent undo history is left untouched.
