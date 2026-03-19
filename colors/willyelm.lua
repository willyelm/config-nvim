vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "willyelm"

local c = require("theme.colors")

local function hi(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Standard UI Highlights
hi("Title", { fg = c.fg_primary })
hi("Normal", { fg = c.fg_body, bg = c.bg_main })
hi("Cursor", { fg = c.fg_body, bg = c.bg_inverse })
hi("TermCursor", { fg = c.fg_primary, bg = c.fg_primary })
hi("Comment", { fg = c.fg_muted, italic = true })
hi("String", { fg = c.fg_string })
hi("Number", { fg = c.fg_warning })
hi("Float", { link = "Number" })
hi("Boolean", { link = "Number" })
-- hi("Constant", { fg = c.fg_body })
hi("Identifier", { fg = c.fg_body })
hi("Function", { fg = c.fg_function })
hi("Statement", { fg = c.fg_primary })
-- hi("Keyword", { fg = c.fg_primary, bold = true })
hi("Keyword", { fg = c.fg_accent })

-- hi("Operator", { fg = c.fg_body, bold = true })
hi("PreProc", { fg = c.fg_secondary })
hi("Type", { fg = c.fg_accent })
hi("Special", { link = "Keyword" })
hi("Underlined", { underline = true })
hi("Error", { fg = c.fg_contrast, bg = c.bg_negative, bold = true })
hi("Todo", { fg = c.fg_accent, underline = true })
hi("LineNr", { fg = c.fg_muted })
hi("CursorLine", { bg = c.bg_active })
hi("CursorLineNr", { bg = c.bg_active })
hi("Visual", { fg = c.fg_inverse, bg = c.bg_visual })
hi("Search", { fg = c.fg_inverse, bg = c.bg_search })
hi("VertSplit", { fg = c.divider, bg = c.bg_main })
hi("WinSeparator", { fg = c.divider, bg = c.bg_main })
hi("ColorColumn", { fg = c.divider, bg = c.divider })
hi("WinBar", { bg = c.bg_main, sp = c.divider })
hi("WinBarNC", { bg = c.bg_main, sp = c.divider })
hi("StatusLine", { fg = c.fg_muted, bg = c.bg_main, sp = c.divider })
hi("StatusLineNC", { fg = c.fg_secondary, bg = c.bg_main })

-- Diff
hi("DiffAdd", { bg = c.bg_positive })
hi("DiffDelete", { bg = c.bg_negative })
hi("DiffChange", { bg = c.bg_positive })
hi("DiffText", { fg = c.fg_inverse, bg = c.fg_positive })

-- Git
hi("GitSignsAddPreview", { link = "DiffAdd" })
hi("GitSignsDeletePreview", { link = "DiffDelete" })
hi("GitSignsAdd", { fg = c.fg_positive, bg = c.bg_main })
hi("GitSignsChange", { fg = c.fg_warning, bg = c.bg_main })
hi("GitSignsDelete", { fg = c.fg_negative, bg = c.bg_main })

-- Semantic Highlights
hi("@property", { fg = c.fg_primary })
hi("@field", { fg = c.fg_primary })
hi("@function", { fg = c.fg_function })
hi("@function.call", { fg = c.fg_function })
hi("@variable", { fg = c.fg_primary })
hi("@variable.parameter", { fg = c.fg_function })
hi("@parameter", { fg = c.fg_function })
hi("@type", { fg = c.fg_accent })
-- hi("@type.builtin", { fg = c.fg_accent, bold = true })
-- hi("@keyword.type", { fg = c.fg_accent, bold = true })

hi("@keyword", { link = "Keyword" })
hi("@keyword.function", { link = "Keyword" })
hi("@operator", { fg = c.fg_body, bold = true })
hi("@method", { fg = c.fg_function })
hi("@method.call", { fg = c.fg_function })
hi("@enum", { fg = c.fg_accent })
hi("@enumMember", { fg = c.fg_warning })
hi("@module", { fg = c.fg_accent })
-- hi("@module.builtin", { fg = c.fg_info })
hi("@namespace", { fg = c.fg_accent })
-- hi("@tag.builtin.tsx", {})
hi("@tag.tsx", {})
hi("@tag.attribute.tsx", { link = "Normal" })
hi("@type.tsx", { fg = c.fg_accent, force = true })

-- Pmenu (Floating Windows/Completion)
hi("NormalFloat", { bg = c.bg_main, fg = c.fg_body, ctermbg = "none" })
hi("FloatBorder", { fg = c.divider, bg = c.bg_main })
hi("Pmenu", { fg = c.fg_body, bg = c.bg_main })
hi("PmenuSel", { fg = c.fg_inverse, bg = c.fg_accent, bold = true })
hi("PmenuSbar", { bg = c.bg_main })
hi("PmenuDoc", { bg = c.bg_main })
hi("PmenuThumb", { bg = c.bg_active })
hi("PmenuBorder", { fg = c.divider, bg = c.bg_main })
hi("PmenuDocBorder", { fg = c.divider, bg = c.bg_main })

hi("CmpItemAbbrMatch", { fg = c.fg_info, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.fg_info, bold = true })
hi("CmpItemKindFunction", { fg = c.fg_accent })
hi("CmpItemKindMethod", { fg = c.fg_accent })
hi("CmpItemKindVariable", { fg = c.fg_link })
hi("CmpItemKindKeyword", { fg = c.fg_primary })
hi("CmpItemKindType", { fg = c.fg_warning })

-- Tree
hi("NvimTreeNormal", { fg = c.fg_body })
hi("NvimTreeFile", { fg = c.fg_body })
hi("NvimTreeExecFile", { link = "NvimTreeFile" })
hi("NvimTreeImageFile", { link = "NvimTreeFile" })
hi("NvimTreeFolderName", { fg = c.fg_body })
hi("NvimTreeRootFolder", { fg = c.fg_primary, bold = true, underline = true })
-- hi("NvimTreeIndentMarker", { fg = c.fg_muted })
hi("NvimTreeFolderIcon", { fg = c.fg_body })
hi("NvimTreeOpenedFolderName", { fg = c.fg_primary })
hi("NvimTreeOpenedFile", { fg = c.fg_primary, bold = true })
hi("NvimTreeWinSeparator", { fg = c.divider, bg = c.bg_main })
hi("NvimTreeGitIgnored", { link = "Comment" })

-- Barbecue
hi("Barbecue", { bg = c.bg_main })

-- Pulse
if vim.o.background == "dark" then
	hi("PulseDiffNAdd", { bg = c.green_07, fg = c.fg_body })
	hi("PulseDiffNDelete", { bg = c.red_07, fg = c.fg_body })
	-- else
	--   hi("PulseDiffNAdd", { fg = c.green_07 })
	--   hi("PulseDiffNDelete", { fg = c.red_07
end

-- Telescope
-- hi("TelescopeNormal", { link = "NormalFloat" })
hi("TelescopeBorder", { fg = c.divider })
-- hi("TelescopePromptNormal", { link = "NormalFloat" })
-- hi("TelescopePromptBorder", { fg = c.divider })
-- hi("TelescopeResultsNormal", { link = "NormalFloat" })
-- hi("TelescopeResultsBorder", { fg = c.divider })
-- hi("TelescopePreviewNormal", { link = "NormalFloat" })
-- hi("TelescopePreviewBorder", { fg = c.divider })
