local M = {}

function M.setup()
  -- Bracket/quote pairs everywhere, tag closing (`>`, `</`, self-closing `/`)
  -- in markup buffers, and surround on a `gs` prefix so bare `s` keeps its
  -- native "substitute": gsa add (motion / visual), gsd delete, gsr replace;
  -- `t` is a tag (`gsaiwt`). Renaming the paired tag is LSP linked editing
  -- (setup/lsp.lua), not clasp.
  require("clasp").setup()
end

return M
