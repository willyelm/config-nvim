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
- An OpenAI-`/v1/completions`-compatible server for AI completion -- see
  [AI completion](#ai-completion); [Ollama](https://ollama.com) running
  `qwen2.5-coder:7b` locally by default

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
brew install gopls lua-language-server marksman

# Web (as needed)
npm install -g @vtsls/language-server vscode-langservers-extracted \
  yaml-language-server @tailwindcss/language-server @biomejs/biome \
  prettier @fsouza/prettierd

# Go formatter
go install golang.org/x/tools/cmd/goimports@latest
```

Formatting runs on save via **conform.nvim**: `biome` for JS/TS/JSON, `prettierd`
for CSS/HTML/YAML/Markdown, `goimports` for Go, `stylua` for Lua. SVG is also
`prettierd` (prettier has no SVG parser, so it's forced through the HTML one,
which works because real SVGs only use real SVG tag names); generic XML uses
`xmllint --format` instead, since prettier's HTML parser doesn't know which
arbitrary XML tags are block-level and leaves them squashed on one line.
Needs `libxml2` (`xmllint`) — ships with macOS, `apt install libxml2-utils` on
Debian/Ubuntu.

## AI completion

`minuet-ai.nvim` (`lua/setup/cmp.lua`) plugs into `blink.cmp` as a completion
source, the same slot `lsp` / `buffer` / `path` occupy. It's a thin client:
it formats the buffer around the cursor into a fill-in-the-middle (FIM)
request, sends it to whatever server you point it at, and turns the response
into a normal completion item. It doesn't run any model itself and isn't
tied to Ollama specifically -- it's `provider = "openai_fim_compatible"`, so
**any server that speaks the OpenAI `/v1/completions` API with `prompt` +
`suffix`** works: Ollama (what's configured now), llama.cpp's server,
vLLM, LM Studio, or a hosted endpoint. Point it at OpenAI/Claude/Gemini's
own APIs instead and it switches to their native protocols.

To change server/model, edit `provider_options.openai_fim_compatible` in
`lua/setup/cmp.lua`:

```lua
openai_fim_compatible = {
  api_key = "TERM",        -- name of an env var to read; "TERM" is a dummy
                            -- value since local servers don't check it
  name = "Ollama",
  end_point = "http://localhost:11434/v1/completions",
  model = "qwen2.5-coder:7b",
},
```

Only swap the model if the server confirms it supports `insert`/FIM --
that's model-specific, not universal (`qwen3-coder:30b` failed this on
Ollama with "does not support insert"; verify with a raw request first):

```bash
curl -s http://localhost:11434/v1/completions -d '{
  "model": "<model>", "prompt": "function add(a, b) {\n  return",
  "suffix": "\n}", "max_tokens": 10
}'
```

**Multiple servers/providers**: `minuet.setup()` takes as many entries under
`provider_options` as you want (`openai_fim_compatible`, `openai`, `claude`,
`gemini`, ...) in the same call -- only the one named by the top-level
`provider` field is active, but you can switch at runtime with
`:Minuet change_provider <name>` without restarting Neovim.

`<leader><Right>` toggles the source on/off (`:Minuet blink toggle`).

## Treesitter

Parsers install automatically for the languages in `lua/setup/treesitter.lua`.
For anything else:

```
:TSInstall <lang>
```

## Features

| Area | Plugins |
| --- | --- |
| Completion | `blink.cmp`, `minuet-ai.nvim` (see [AI completion](#ai-completion)), `friendly-snippets` |
| Treesitter | `nvim-treesitter` (main), `-textobjects`, `-context`, `nvim-ts-context-commentstring` |
| Folding | native `vim.treesitter.foldexpr()`, upgraded to `vim.lsp.foldexpr()` per-buffer when the server supports folding ranges; folds persist per file |
| Editing | `mini.surround`, `treesj` (split/join), `vim-matchup`, `nvim-autopairs`, `nvim-ts-autotag` |
| Diagnostics | native `vim.diagnostic` virtual lines (current line only) |
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
| `K` | Hover docs · `<leader>K` open fold, else hover |
| `<leader>ra` / `<F4>` / `<leader>a` | Code actions (native / native / Pulse) |
| `<leader>rs` / `<F2>` | Rename symbol |
| `<F3>` | Format buffer |
| `gl` | Line diagnostics float |
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
| `<leader>K` | Open fold under cursor |

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
