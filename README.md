# Neovim Config

Personal setup built on Neovim's built-in `vim.pack` package manager. Optimized
for web development (TypeScript / JSX), Go, and general editing with the native
LSP client, treesitter, folding, completion, formatting and git integration.

## Requirements

- Neovim >= 0.12
- Git, [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)
- Node.js >= 18 and a C compiler (`cc`/`gcc`) for treesitter parsers
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) (`npm i -g tree-sitter-cli`)
- A Nerd Font (for completion / statusline / breadcrumb icons)

## Installation

```bash
git clone https://github.com/willyelm/nvim ~/.config/nvim
cd ~/.config/nvim
nvim
```

`vim.pack` installs the managed plugins on first launch and records them in
`nvim-pack-lock.json`. Restart Neovim once after the first install pass. On the
first start after that, `blink.cmp` compiles its Rust fuzzy matcher once and
nvim-treesitter installs parsers in the background (`:TSUpdate` to refresh).

## LSP & formatters

Uses the **native LSP client**. Install the servers you need on your system:

```bash
# Go / Lua
brew install gopls lua-language-server

# Web (as needed)
npm install -g @vtsls/language-server vscode-langservers-extracted \
  yaml-language-server @tailwindcss/language-server @biomejs/biome \
  prettier @fsouza/prettierd

# Go formatter
go install golang.org/x/tools/cmd/goimports@latest
```

Formatting runs on save via **conform.nvim**: `biome` for JS/TS/JSON, `prettierd`
for CSS/HTML/YAML/Markdown, `goimports` for Go, `stylua` for Lua.

## Treesitter

Parsers install automatically for the languages in `lua/setup/treesitter.lua`.
For anything else:

```
:TSInstall <lang>
```

## Features

| Area | Plugins |
| --- | --- |
| Completion | `blink.cmp`, `blink-copilot` + `copilot.lua` (menu only), `friendly-snippets` |
| Treesitter | `nvim-treesitter` (main), `-textobjects`, `-context`, `nvim-ts-context-commentstring` |
| Folding | `nvim-ufo` (LSP → treesitter → indent), folds persist per file |
| Editing | `mini.surround`, `treesj` (split/join), `vim-matchup`, `nvim-autopairs`, `nvim-ts-autotag` |
| Diagnostics | `tiny-inline-diagnostic` |
| Git | `gitsigns`, `pulse.nvim` (history / status) |
| Search | `pulse.nvim` (files / grep / buffers), `grug-far` (search & replace) |
| UI | `lualine`, `dropbar` (breadcrumbs), `nvim-colorizer`, `which-key`, custom `willyelm` colorscheme |

## Keymaps

Leader is `<Space>`.

### Navigation & search

| Key | Action |
| --- | --- |
| `<leader>p` | Pulse menu |
| `<leader>f` | Fuzzy search in buffer |
| `<leader>l` | Live grep |
| `<leader>b` | Open buffers |
| `<leader>sr` | Search & replace (grug-far) |
| `<leader><Tab>` | Next window |

### LSP (buffer-local)

| Key | Action |
| --- | --- |
| `gd` / `gD` / `gi` / `go` / `gr` | Definition / declaration / implementation / type / references |
| `K` | Hover docs · `<leader>K` peek fold, else hover |
| `<leader>ra` / `<F4>` / `<leader>a` | Code actions (native / native / Pulse) |
| `<leader>rs` / `<F2>` | Rename symbol |
| `<F3>` | Format buffer |
| `<leader>d` / `gl` | Line diagnostics float |
| `]d` / `[d` | Next / prev diagnostic |
| `]e` / `[e` | Next / prev error |

### Editing

| Key | Action |
| --- | --- |
| `<leader>/` | Toggle comment (JSX-aware) |
| `af`/`if` `ac`/`ic` `aa`/`ia` `ai`/`ii` `al`/`il` | function / class / parameter / conditional / loop textobjects |
| `]f` / `[f`, `]a` / `[a` | Jump to next / prev function, parameter |
| `<leader>rp` / `<leader>rP` | Swap parameter with next / prev |
| `gsa` / `gsd` / `gsr` | Add / delete / replace surround (`gsat` for JSX tags) |
| `<leader>j` / `<leader>J` | Split-join / join the node under the cursor |
| `%` | Jump between matching tags / keywords |
| `<M-Up>` / `<M-Down>` | Move line or block |
| `<leader>.` / `<leader>,` | Indent / dedent selection |

### Folding

| Key | Action |
| --- | --- |
| `za` / `<leader>z` | Toggle fold under cursor |
| `zR` / `zM` | Open / close all folds |
| `zr` / `zm` | Open / close one level |
| `<leader>K` | Peek folded lines |

### Git

| Key | Action |
| --- | --- |
| `<leader>gd` | Diff current file |
| `<leader>gr` | Reset file |
| `<leader>gs` | Git status (Pulse) |
| `<leader>gh` / `<leader>gp` | File / project history |

### Completion (insert mode)

| Key | Action |
| --- | --- |
| `<C-y>` | Accept · `<CR>` accepts only an explicit selection |
| `<Tab>` / `<S-Tab>` | Select next / prev, then jump snippet placeholder |
| `<C-l>` / `<C-h>` | Jump snippet placeholder |
| `<C-Space>` | Toggle menu · `<C-k>` signature help |

## Maintenance

### Syncing updates with vim.pack

If `vim.pack` leaves updates pending, clear lock files then update:

```
find ~/.local/share/nvim/site/pack/ -name "index.lock" -delete
```

```
:lua vim.pack.update()
```

### Clean reinstall

If plugin state gets inconsistent (leftovers from a previous plugin manager,
stale treesitter queries on the runtimepath):

```
./scripts/clean-reinstall.sh
```

It removes old `lazy/`, `pack/packer/`, `mason/` trees and the symlinked query
directory, then you launch `nvim` once so `vim.pack` and nvim-treesitter rebuild
everything. Persistent undo history is left untouched.
