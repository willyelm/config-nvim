return {
  cmd = { "vtsls", "--stdio" },
  -- Force full-document sync instead of incremental: nvim-ts-autotag and
  -- autopairs fired several small edits per keystroke on JSX tags, a known
  -- trigger for incremental-sync desync between the buffer and tsserver's
  -- copy — bogus "parsing" diagnostics that only cleared on a restart.
  -- clasp makes one edit per keystroke, so incremental sync may be safe
  -- again; full sync resends the whole buffer, so there's nothing to desync.
  flags = { allow_incremental_sync = false },
  init_options = {
    hostInfo = "neovim",
  },
  -- One tsserver per repo (lockfile), not per package.json in a monorepo;
  -- tsserver still resolves the nearest tsconfig per file.
  root_markers = {
    { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock", "bun.lockb" },
    ".git",
  },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  settings = {
    vtsls = {
      -- Use the repo's own TypeScript (node_modules) when present, so the
      -- server matches what `tsc` in the project would report.
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      -- One tsserver serves the whole monorepo; the 3 GB default is what
      -- makes it die mid-session and need :LspRestart.
      tsserver = { maxTsServerMemory = 8192 },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = false },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = false },
        functionLikeReturnTypes = { enabled = false },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        importModuleSpecifierPreference = "non-relative",
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeCompletionsWithInsertText = true,
        providePrefixAndSuffixTextForRename = true,
        allowRenameOfImportPath = true,
      },
    },
  },
}
