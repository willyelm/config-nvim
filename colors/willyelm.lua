vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "willyelm"

local color = require("theme.colors")()

local function hi(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Standard UI Highlights
hi("Title", { fg = color.fg_primary })
hi("Normal", { fg = color.fg_body, bg = color.bg_main })
hi("Cursor", { fg = color.fg_body, bg = color.bg_inverse })
hi("TermCursor", { fg = color.fg_primary, bg = color.fg_primary })
hi("Comment", { fg = color.fg_muted, italic = true })
hi("String", { fg = color.fg_string })
hi("Number", { fg = color.fg_warning })
hi("Float", { link = "Number" })
hi("Boolean", { link = "Number" })
hi("Identifier", { fg = color.fg_body })
hi("Function", { fg = color.fg_function })
hi("Statement", { fg = color.fg_primary })
hi("Keyword", { fg = color.fg_accent })
hi("PreProc", { fg = color.fg_secondary })
hi("Type", { fg = color.fg_accent })
hi("Special", { link = "Keyword" })
hi("Underlined", { underline = true })
hi("Error", { fg = color.fg_contrast, bg = color.bg_negative, bold = true })
hi("Todo", { fg = color.fg_accent, underline = true })
hi("LineNr", { fg = color.fg_muted })
hi("CursorLine", { bg = color.bg_active })
hi("CursorLineNr", { bg = color.bg_active })
hi("Visual", { fg = color.fg_inverse, bg = color.bg_visual })
hi("Search", { fg = color.fg_inverse, bg = color.bg_search })
hi("VertSplit", { fg = color.divider, bg = color.bg_main })
hi("WinSeparator", { fg = color.divider, bg = color.bg_main })
hi("ColorColumn", { fg = color.divider, bg = color.divider })
hi("WinBar", { bg = color.bg_main, sp = color.divider })
hi("WinBarNC", { bg = color.bg_main, sp = color.divider })
hi("StatusLine", { fg = color.fg_muted, bg = color.bg_main, sp = color.divider })
hi("StatusLineNC", { fg = color.fg_secondary, bg = color.bg_main })

-- Diff
hi("DiffAdd", { bg = color.bg_positive })
hi("DiffDelete", { bg = color.bg_negative })
hi("DiffChange", { bg = color.bg_positive })
hi("DiffText", { fg = color.fg_inverse, bg = color.fg_positive })

-- Git
hi("GitSignsAddPreview", { link = "DiffAdd" })
hi("GitSignsDeletePreview", { link = "DiffDelete" })
hi("GitSignsAdd", { fg = color.fg_positive, bg = color.bg_main })
hi("GitSignsChange", { fg = color.fg_warning, bg = color.bg_main })
hi("GitSignsDelete", { fg = color.fg_negative, bg = color.bg_main })

-- Semantic Highlights
hi("@property", { fg = color.fg_primary })
hi("@field", { fg = color.fg_primary })
hi("@function", { fg = color.fg_function })
hi("@function.call", { fg = color.fg_function })
hi("@variable", { fg = color.fg_primary })
hi("@variable.parameter", { fg = color.fg_function })
hi("@parameter", { fg = color.fg_function })
hi("@type", { fg = color.fg_accent })

hi("@keyword", { link = "Keyword" })
hi("@keyword.function", { link = "Keyword" })
hi("@operator", { fg = color.fg_body, bold = true })
hi("@method", { fg = color.fg_function })
hi("@method.call", { fg = color.fg_function })
hi("@enum", { fg = color.fg_accent })
hi("@enumMember", { fg = color.fg_warning })
hi("@module", { fg = color.fg_accent })
hi("@namespace", { fg = color.fg_accent })
hi("@tag.tsx", {})
hi("@tag.attribute.tsx", { link = "Normal" })
hi("@type.tsx", { fg = color.fg_accent, force = true })

-- Pmenu (Floating Windows/Completion)
hi("NormalFloat", { bg = color.bg_main, fg = color.fg_body, ctermbg = "none" })
hi("FloatBorder", { fg = color.divider, bg = color.bg_main })
hi("Pmenu", { fg = color.fg_body, bg = color.bg_main })
hi("PmenuSel", { fg = color.fg_inverse, bg = color.fg_accent, bold = true })
hi("PmenuSbar", { bg = color.bg_main })
hi("PmenuDoc", { bg = color.bg_main })
hi("PmenuThumb", { bg = color.bg_active })
hi("PmenuBorder", { fg = color.divider, bg = color.bg_main })
hi("PmenuDocBorder", { fg = color.divider, bg = color.bg_main })

hi("CmpItemAbbrMatch", { fg = color.fg_info, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = color.fg_info, bold = true })
hi("CmpItemKindFunction", { fg = color.fg_accent })
hi("CmpItemKindMethod", { fg = color.fg_accent })
hi("CmpItemKindVariable", { fg = color.fg_link })
hi("CmpItemKindKeyword", { fg = color.fg_primary })
hi("CmpItemKindType", { fg = color.fg_warning })

-- Tree
hi("NvimTreeNormal", { fg = color.fg_body })
hi("NvimTreeFile", { fg = color.fg_body })
hi("NvimTreeExecFile", { link = "NvimTreeFile" })
hi("NvimTreeImageFile", { link = "NvimTreeFile" })
hi("NvimTreeFolderName", { fg = color.fg_body })
hi("NvimTreeRootFolder", { fg = color.fg_primary, bold = true, underline = true })
hi("NvimTreeFolderIcon", { fg = color.fg_body })
hi("NvimTreeOpenedFolderName", { fg = color.fg_primary })
hi("NvimTreeOpenedFile", { fg = color.fg_primary, bold = true })
hi("NvimTreeWinSeparator", { fg = color.divider, bg = color.bg_main })
hi("NvimTreeGitIgnored", { link = "Comment" })

-- Barbecue
hi("Barbecue", { bg = color.bg_main })

-- Pulse
if vim.o.background == "dark" then
	hi("PulseDiffNAdd", { bg = color.green_07, fg = color.fg_body })
	hi("PulseDiffNDelete", { bg = color.red_07, fg = color.fg_body })
else
	hi("PulseDiffNAdd", { bg = color.green_02, fg = color.fg_body })
	hi("PulseDiffNDelete", { bg = color.red_02, fg = color.fg_body })
end

-- Telescope
hi("TelescopeBorder", { fg = color.divider })
