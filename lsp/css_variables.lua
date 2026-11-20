-- cssls only completes custom properties declared in the current file; this
-- indexes every stylesheet in the repo so `var(--` finds theme variables.
-- CSS-only: it returns every variable regardless of context, which would
-- flood completions in JS/TS.
return {
  cmd = { "css-variables-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = {
    { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lock", "bun.lockb" },
    ".git",
  },
  -- Required: the server crashes on startup when these come back empty.
  settings = {
    cssVariables = {
      lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
      blacklistFolders = {
        "**/.cache",
        "**/.DS_Store",
        "**/.git",
        "**/.hg",
        "**/.next",
        "**/.svn",
        "**/bower_components",
        "**/CVS",
        "**/dist",
        "**/node_modules",
        "**/tests",
        "**/tmp",
      },
    },
  },
}
