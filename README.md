# Neovim Config

My personal Neovim setup configured with Neovim's built-in `vim.pack` package manager. Optimized for web development, scripting, and general editing with LSP, formatting, git integration, and modern UI enhancements.

## Requirements

- Neovim >= 0.12.0
- Git
- Node.js >= 18
- ripgrep (`rg`)
- GCC + make (for telescope-fzf-native)

## Installation

```bash
# Clone this config
git clone https://github.com/willyelm/nvim ~/.config/nvim
cd ~/.config/nvim
nvim
```

`vim.pack` will automatically install managed plugins on first launch and track them in `nvim-pack-lock.json`.

## Ghostty Theme

If you want your terminal to match this Neovim palette, use `colors/willyelm.ghostty` as your Ghostty config snippet or copy its theme section into your existing Ghostty config.

## Mason Tools (auto-installed via mason.nvim)

### LSP Servers

- **vtsls** - TypeScript/JavaScript (with Biome integration)
- **lua_ls** - Lua
- **gopls** - Go
- **pyright** - Python
- **jsonls** - JSON
- **yamlls** - YAML
- **html** - HTML
- **mdx_analyzer** - MDX
- **cssls** - CSS/SCSS
- **tailwindcss** - Tailwind CSS

### Formatters

- **biome** - TypeScript/JavaScript/JSON (via Conform)
- **prettierd** - HTML/CSS/YAML/Markdown/GraphQL
- **goimports** - Go

## Features

### LSP & Code Intelligence

- Language Server Protocol via lsp-zero
- Autocompletion with nvim-cmp
- Treesitter syntax highlighting and text objects
- Auto-pairs and auto-tag insertion
- Inline diagnostics with tiny-inline-diagnostic
- Inlay hints for type information
- Code actions and symbol renaming

### Code Formatting

- Conform.nvim for automated formatting on save
- Biome for JavaScript/TypeScript/JSON
- Prettier for styling languages
- goimports for Go

### Git Integration

- **Gitsigns** - Inline git indicators and blame
- **Diffview** - Side-by-side diff viewing
- **Neogit** - Interactive git operations
- **Telescope** - Git history, branches, and stash browsing

### Search & Navigation

- **Pulse.nvim** - Custom fuzzy finder with live grep
- **Grug-far** - Search and replace across files
- **Telescope** - File finding, git integration, undo history
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
| `gl`         | Show line diagnostics |
| `<leader>ra` | Code actions          |
| `<leader>rs` | Rename symbol         |
| `<leader>h`  | Highlight word        |
| `<leader>/`  | Toggle comment        |
| `<leader>x`  | Close buffer          |
| `<leader>X`  | Close all buffers     |
| `<C-s>`      | Save file             |
| `<M-Down>`   | Move line down        |
| `<M-Up>`     | Move line up          |
| `<leader>.`  | Increase indent       |
| `<leader>,`  | Decrease indent       |
| `<leader>c`  | Copy file location    |
