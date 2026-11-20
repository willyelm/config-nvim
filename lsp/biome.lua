-- Prefer the project's biome (nearest node_modules, walking up for monorepos)
-- so the LSP matches the version conform formats with and understands the
-- repo's biome.json; fall back to a global install.
local function biome_bin(root)
  for dir in vim.fs.parents(root .. "/_") do
    local bin = dir .. "/node_modules/.bin/biome"
    if vim.uv.fs_stat(bin) then
      return bin
    end
  end
  return "biome"
end

return {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.uv.cwd()
    return vim.lsp.rpc.start({ biome_bin(root), "lsp-proxy" }, dispatchers, { cwd = root })
  end,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "biome.json", "biome.jsonc" },
  -- Only in projects that configure biome; otherwise it lints every JS/TS
  -- file with its defaults. Formatting goes through conform.
  workspace_required = true,
  flags = { allow_incremental_sync = false },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
