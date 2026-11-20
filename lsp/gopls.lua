return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { { "go.work" }, { "go.mod" }, ".git" },
  flags = { allow_incremental_sync = false },
  settings = {
    gopls = {
      usePlaceholders = true,
      staticcheck = true,
    },
  },
}
