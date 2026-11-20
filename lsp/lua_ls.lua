return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml" }, ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      -- Just the Neovim runtime + luv types. Indexing every plugin on the
      -- runtimepath kept lua_ls busy for seconds on each start.
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
      },
      telemetry = { enable = false },
    },
  },
}
