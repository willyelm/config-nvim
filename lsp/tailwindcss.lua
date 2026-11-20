-- Tailwind only where a project uses it: a tailwind config (v3) or a
-- package.json that depends on tailwindcss (v4 has no config file).
-- A bare package.json marker started the server in every JS repo.
local function tailwind_root(bufnr, on_dir)
  local root = vim.fs.root(bufnr, {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
  })
  if root then
    return on_dir(root)
  end
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
  for _, pkg in ipairs(vim.fs.find("package.json", { path = path, upward = true, limit = math.huge })) do
    local ok, lines = pcall(vim.fn.readfile, pkg)
    if ok and table.concat(lines, "\n"):find('"tailwindcss"', 1, true) then
      return on_dir(vim.fs.dirname(pkg))
    end
  end
end

return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = tailwind_root,
  settings = {
    tailwindCSS = {
      validate = true,
      classFunctions = { "cva", "cx", "clsx", "cn", "tw" },
    },
  },
}
