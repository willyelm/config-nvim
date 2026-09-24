# Neovim Config

Personal setup built on Neovim's built-in `vim.pack` package manager. Optimized
for TypeScript/JSX, Go, Lua, C/C++, and Python, with the native LSP client,
treesitter, folding, completion, formatting and git integration.

## Requirements

- Neovim >= 0.12
- Git, [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)
- Node.js >= 18 and a C compiler (`cc`/`gcc`) for treesitter parsers
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter)
  (`npm i -g tree-sitter-cli`)
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
# Go, Lua, C/C++, Python, Markdown language servers + formatters
brew install gopls lua-language-server marksman clangd pyright stylua \
  clang-format ruff

# Web (as needed)
npm install -g @vtsls/language-server vscode-langservers-extracted \
  yaml-language-server @tailwindcss/language-server @biomejs/biome \
  prettier @fsouza/prettierd

# Go formatter
go install golang.org/x/tools/cmd/goimports@latest
```

Formatting runs on save via **conform.nvim**: `biome` for JS/TS/JSON,
`prettierd` for CSS/HTML/YAML/Markdown, `goimports` for Go, `stylua` for Lua,
`clang-format` for C/C++, `ruff` for Python. SVG is also `prettierd` (prettier
has no SVG parser, so it's forced through the HTML one, which works because
real SVGs only use real SVG tag names); generic XML uses `xmllint --format`
instead, since prettier's HTML parser doesn't know which arbitrary XML tags
are block-level and leaves them squashed on one line. Needs `libxml2`
(`xmllint`) — ships with macOS, `apt install libxml2-utils` on
Debian/Ubuntu.

## AI Completion

Off by default. Set `AI_COMPLETION_ENABLED = true` at the top of
`lua/setup/cmp.lua` to turn it on. `minuet-ai.nvim` feeds an
`openai_fim_compatible` source into `blink.cmp`. works with any
OpenAI-`/v1/completions`-compatible server (Ollama, llama.cpp, vLLM, LM Studio,
hosted). Requires a running server; nothing else in this config depends on it.

To change server/model, edit `provider_options.openai_fim_compatible`. Only
switch models that confirm `insert`/FIM support (`qwen3-coder:30b` doesn't;
`qwen2.5-coder:7b` does) — test with:

```bash
curl -s http://localhost:11434/v1/completions -d '{
  "model": "<model>", "prompt": "function add(a, b) {\n  return",
  "suffix": "\n}", "max_tokens": 10
}'
```

Multiple `provider_options` entries can coexist; switch at runtime with
`:Minuet change_provider <name>`.

## Treesitter

Parsers install automatically for the languages in `lua/setup/treesitter.lua`.
For anything else:

```
:TSInstall <lang>
```

## Features

| Area        | Plugins                                                                                                                                         |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Completion  | `blink.cmp`, `minuet-ai.nvim` (see [AI completion](#ai-completion))                                                                              |
| Treesitter  | `nvim-treesitter` (main), `-textobjects`, `-context`                                                                                             |
| Folding     | native `vim.treesitter.foldexpr()`, upgraded to `vim.lsp.foldexpr()` per-buffer when the server supports folding ranges; folds persist per file |
| Editing     | `mini.surround`, `vim-matchup`, `nvim-autopairs`, `nvim-ts-autotag`                                                                              |
| Diagnostics | native `vim.diagnostic` virtual lines (current line only)                                                                                       |
| Git         | `gitsigns`, `pulse.nvim` (history / status)                                                                                                     |
| Search      | `pulse.nvim` (files / grep / buffers), `grug-far` (search & replace)                                                                            |
| UI          | `lualine`, `dropbar` (breadcrumbs), `nvim-colorizer`, `which-key`, custom `willyelm` colorscheme                                                |

## Keymaps

Leader is `<Space>`.

### Navigation & search

| Key             | Action                      |
| --------------- | --------------------------- |
| `<leader>p`     | Pulse menu                  |
| `<leader>f`     | Fuzzy search in buffer      |
| `<leader>l`     | Live grep                   |
| `<leader>b`     | Open buffers                |
| `<leader>sr`    | Search & replace (grug-far) |
| `<leader><Tab>` | Next window                 |

### LSP (buffer-local)

| Key                                 | Action                                                        |
| ----------------------------------- | ------------------------------------------------------------- |
| `gd` / `gD` / `gi` / `go` / `gr`    | Definition / declaration / implementation / type / references |
| `K`                                 | Hover docs · `<leader>K` open fold, else hover                |
| `<leader>ra` / `<F4>` / `<leader>a` | Code actions (native / native / Pulse)                        |
| `<leader>rs` / `<F2>`               | Rename symbol                                                 |
| `<F3>`                              | Format buffer                                                 |
| `gl`                                | Line diagnostics float                                        |
| `]d` / `[d`                         | Next / prev diagnostic                                        |
| `]e` / `[e`                         | Next / prev error                                             |

### Editing

| Key                                               | Action                                                        |
| ------------------------------------------------- | ------------------------------------------------------------- |
| `af`/`if` `ac`/`ic` `aa`/`ia` `ai`/`ii` `al`/`il` | function / class / parameter / conditional / loop textobjects |
| `]f` / `[f`, `]a` / `[a`                          | Jump to next / prev function, parameter                       |
| `<leader>rp` / `<leader>rP`                       | Swap parameter with next / prev                               |
| `gsa` / `gsd` / `gsr`                             | Add / delete / replace surround (`gsat` for JSX tags)         |
| `%`                                               | Jump between matching tags / keywords                         |
| `<M-Up>` / `<M-Down>`                             | Move line or block                                            |
| `<leader>.` / `<leader>,`                         | Indent / dedent selection                                     |

### Folding

| Key                | Action                   |
| ------------------ | ------------------------ |
| `za`                | Toggle fold under cursor |
| `zR` / `zM`        | Open / close all folds   |
| `zr` / `zm`        | Open / close one level   |
| `<leader>K`        | Open fold under cursor   |

### Git

| Key                         | Action                 |
| --------------------------- | ---------------------- |
| `<leader>gd`                | Diff current file      |
| `<leader>gr`                | Reset file             |
| `<leader>gs`                | Git status (Pulse)     |
| `<leader>gh` / `<leader>gp` | File / project history |

### Completion (insert mode)

| Key                 | Action                                             |
| ------------------- | -------------------------------------------------- |
| `<C-y>`             | Accept · `<CR>` accepts only an explicit selection |
| `<Tab>` / `<S-Tab>` | Select next / prev, then jump snippet placeholder  |
| `<C-Space>`         | Toggle menu · `<C-k>` signature help               |

## Maintenance

### Syncing updates with vim.pack

If `vim.pack` leaves updates pending, clear lock files then update:

```
find ~/.local/share/nvim/site/pack/ -name "index.lock" -delete
```

```
:lua vim.pack.update()
```
