local M = {}

function M.setup()
  -- Surround on a `gs` prefix so bare `s` keeps its native "substitute"
  -- meaning (mini.surround maps `s` to <Nop> if its mappings start with `s`).
  -- gsa add (takes a motion / visual), gsd delete, gsr replace, gsf/gsF find.
  -- Works on JSX tags via the `t` target, e.g. `gsat`.
  require("mini.surround").setup({
    n_lines = 50,
    search_method = "cover_or_next",
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
      suffix_last = "l",
      suffix_next = "n",
    },
  })
end

return M
