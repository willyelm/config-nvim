# Neovim Config

This is my personal neovim setup as my primary editor. This config includes
basic features to start using neovim as IDE.

## Requirements

- Neovim >= 0.9.5
- Git
- Node.js >= 18
- NPM
- Go (for gopls)
- ripgrep (`rg`)
- fd (`fdfind`)
- GCC + make (for telescope-fzf-native)

## Installation

```bash
# Clone this config
git clone https://github.com/yourusername/nvim ~/.config/nvim
```

## Dependencies

### Global NPM packages

```bash
npm install -g @mdx-js/language-server
```

### Mason Tools (auto-installed)

**LSP Servers:**

- vtsls (TypeScript/JavaScript)
- lua_ls (Lua)
- gopls (Go)
- pyright (Python)
- jsonls (JSON)
- yamlls (YAML)
- html
- mdx_analyzer (MDX)
- cssls (CSS)
- tailwindcss
- biome
- dockerls (Docker)

**Formatters:**

- prettierd
- stylua
- shfmt

**Debug Adapters:**

- js-debug-adapter

## Features

### LSP & Autocomplete

- Language Server Protocol support via lsp-zero
- Auto-completion with nvim-cmp
- TreeSitter for syntax highlighting and textobjects
- Auto-pairs and auto-tags

### AI Integration

- Copilot for code suggestions
- Sidekick for AI agent workflow (OpenCode, Claude, Ollama)

### Git Integration

- Gitsigns for inline git indicators
- Diffview for diff viewing
- Neogit for git operations
- Telescope git extensions

### Search & Navigation

- Telescope for fuzzy finding, live grep, file search
- Grug-far for search and replace
- Flash for quick navigation
- Which-key for keybinding hints

### UI

- NvimTree file explorer
- Lualine statusline
- Barbecue breadcrumbs/winbar
- Aerial outline sidebar
- nvim-scrollbar

### Debugging

- nvim-dap with nvim-dap-ui
- Breakpoints, step-through debugging

### Keymaps

| Key          | Description         |
| ------------ | ------------------- |
| `<Leader>\`  | Toggle NvimTree     |
| `<Leader>f`  | Find in buffer      |
| `<Leader>b`  | Find files          |
| `<Leader>l`  | Live grep           |
| `<Leader>u`  | Undo history        |
| `<Leader>sr` | Search & replace    |
| `<Leader>gd` | Git diff            |
| `<Leader>ga` | Toggle diffview     |
| `<Leader>gz` | Git stash           |
| `<Leader>o`  | Toggle outline      |
| `<Leader>x`  | Close buffer        |
| `<Leader>/`  | Toggle comment      |
| `<C-s>`      | Save file           |
| `K`          | Hover documentation |

### Debug Keys

| Key          | Description            |
| ------------ | ---------------------- |
| `<F5>`       | Start/Continue debug   |
| `<F1>`       | Step into              |
| `<F2>`       | Step over              |
| `<F3>`       | Step out               |
| `<Leader>db` | Toggle breakpoint      |
| `<Leader>dB` | Conditional breakpoint |

### AI Keys

| Key        | Description          |
| ---------- | -------------------- |
| `<M-a>`    | Start Sidekick agent |
| `<M-f>`    | Copilot accept       |
| `<M-b>`    | Copilot dismiss      |
| `<M-Down>` | Copilot next         |
| `<M-Up>`   | Copilot prev         |
