vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "willyelm"
-- Colors
local s = {
	gray_01 = "#BCBCBC",
	gray_02 = "#A8A8A8",
	gray_03 = "#949494",
	gray_04 = "#808080",
	gray_05 = "#6C6C6C",
	gray_06 = "#585858",
	gray_07 = "#444444",
	gray_08 = "#202020",
	orange_01 = "#de9084",
	orange_08 = "#4A2D28",
	red_01 = "#ec7e90",
	red_07 = "#632f36",
	red_08 = "#361f24",
	blue_01 = "#b6d6fd",
	blue_08 = "#1c4059",
	cyan_01 = "#4fb8cc",
	cyan_08 = "#20424a",
	green_01 = "#c6f1d4",
	green_07 = "#334537",
	green_08 = "#242a27",
	purple_01 = "#d5bbfa",
	purple_08 = "#402753",
	yellow_01 = "#f6e191",
	yellow_08 = "#544719",
}
-- Semantic variables
local bg_main, bg_inverse, bg_active, bg_visual, bg_search, bg_positive, bg_negative
local fg_primary, fg_body, fg_secondary, fg_muted, fg_inverse, fg_contrast
local fg_link, fg_info, fg_accent, fg_string, fg_warning, fg_positive, fg_negative
local divider

if vim.o.background == "dark" then
	bg_main = "NONE"
	bg_inverse = s.gray_01
	bg_active = s.gray_08
	bg_visual = s.gray_02
	bg_search = s.yellow_01
	bg_positive = s.green_08
	bg_negative = s.red_08
	fg_primary = s.gray_01
	fg_body = s.gray_03
	fg_secondary = s.gray_05
	fg_muted = s.gray_06
	fg_inverse = s.gray_08
	fg_contrast = s.gray_01
	fg_link = s.blue_01
	fg_info = s.cyan_01
	fg_accent = s.purple_01
	fg_string = s.orange_01
	fg_warning = s.yellow_01
	fg_positive = s.green_01
	fg_negative = s.red_01
	divider = s.gray_07
else
	bg_main = "NONE"
	bg_inverse = s.gray_08
	bg_active = s.gray_02
	bg_visual = s.gray_08
	bg_search = s.yellow_01
	bg_positive = s.green_01
	bg_negative = s.red_01
	fg_primary = s.gray_08
	fg_body = s.gray_08
	fg_secondary = s.gray_06
	fg_muted = s.gray_05
	fg_inverse = s.gray_01
	fg_contrast = s.gray_08
	fg_link = s.blue_08
	fg_info = s.cyan_08
	fg_accent = s.purple_08
	fg_string = s.orange_08
	fg_warning = s.yellow_08
	fg_positive = s.green_07
	fg_negative = s.red_07
	divider = s.gray_04
end

-- Helper Function
local function hi(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Standard UI Highlights
hi("Title", { fg = fg_primary })
hi("Normal", { fg = fg_body, bg = bg_main })
hi("Cursor", { fg = fg_body, bg = bg_inverse })
hi("TermCursor", { fg = fg_primary, bg = fg_primary })
hi("Comment", { fg = fg_muted, italic = true })
hi("String", { fg = fg_string })
hi("Number", { fg = fg_warning })
hi("Float", { link = "Number" })
hi("Boolean", { link = "Number" })
hi("Constant", { fg = fg_body })
hi("Identifier", { fg = fg_body })
hi("Function", { fg = fg_primary })
hi("Statement", { fg = fg_primary, bold = true })
hi("Keyword", { fg = fg_primary, bold = true })
hi("Operator", { fg = fg_body, bold = true })
hi("PreProc", { fg = fg_secondary })
hi("Type", { fg = fg_accent })
hi("Special", { link = "Keyword" })
hi("Underlined", { underline = true })
hi("Error", { fg = fg_contrast, bg = bg_negative, bold = true })
hi("Todo", { fg = fg_accent, underline = true })
hi("Directory", { fg = fg_primary })
hi("LineNr", { fg = fg_muted })
hi("CursorLine", { bg = bg_active })
hi("CursorLineNr", { bg = bg_active })
hi("Visual", { fg = fg_inverse, bg = bg_visual })
hi("Search", { fg = fg_inverse, bg = bg_search })
hi("VertSplit", { fg = divider, bg = bg_main })
hi("WinSeparator", { fg = divider, bg = bg_main })
hi("ColorColumn", { fg = divider, bg = divider })
hi("WinBar", { bg = bg_main, sp = divider })
hi("WinBarNC", { bg = bg_main, sp = divider })
hi("StatusLine", { fg = fg_muted, bg = bg_main, sp = divider })
hi("StatusLineNC", { fg = fg_secondary, bg = bg_main })

-- TypeScript
-- hi("typescriptTypeReference", { link = "Type" })
-- hi("typescriptObjectLabel", { link = "Normal" })
-- hi("typescriptVariable", { link = "Keyword" })

-- Diff
hi("DiffAdd", { bg = bg_positive })
hi("DiffDelete", { bg = bg_negative })
hi("DiffChange", { bg = bg_positive })
hi("DiffText", { fg = fg_inverse, bg = fg_positive })

-- Git
hi("GitSignsAddPreview", { link = "DiffAdd" })
hi("GitSignsDeletePreview", { link = "DiffDelete" })
hi("GitSignsAdd", { fg = fg_positive, bg = bg_main })
hi("GitSignsChange", { fg = fg_warning, bg = bg_main })
hi("GitSignsDelete", { fg = fg_negative, bg = bg_main })

-- Treesitter & Web Dev (TS/JSX/Go)
hi("@tag.builtin.tsx", {})
hi("@tag.tsx", {})
hi("@tag.attribute.tsx", { link = "Normal" })
hi("@type.tsx", { link = "Type", force = true })

-- Pmenu (Floating Windows/Completion)
hi("NormalFloat", { bg = bg_main, fg = fg_body, ctermbg = "none" })
hi("FloatBorder", { fg = divider, bg = bg_main })
hi("Pmenu", { fg = fg_body, bg = bg_main })
hi("PmenuSel", { fg = fg_inverse, bg = fg_accent, bold = true })
hi("PmenuSbar", { bg = bg_main })
hi("PmenuDoc", { bg = bg_main })
hi("PmenuThumb", { bg = bg_active })
hi("PmenuBorder", { fg = divider, bg = bg_main })
hi("PmenuDocBorder", { fg = divider, bg = bg_main })

hi("CmpItemAbbrMatch", { fg = fg_info, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = fg_info, bold = true })
hi("CmpItemKindFunction", { fg = fg_accent })
hi("CmpItemKindMethod", { fg = fg_accent })
hi("CmpItemKindVariable", { fg = fg_link })
hi("CmpItemKindKeyword", { fg = fg_primary })
hi("CmpItemKindType", { fg = fg_warning })

-- Tree
hi("NvimTreeNormal", { fg = fg_body })
hi("NvimTreeFile", { fg = fg_body })
hi("NvimTreeExecFile", { link = "NvimTreeFile" })
hi("NvimTreeImageFile", { link = "NvimTreeFile" })
hi("NvimTreeFolderName", { fg = fg_body })
hi("NvimTreeRootFolder", { fg = fg_primary, bold = true, underline = true })
-- hi("NvimTreeIndentMarker", { fg = fg_muted })
hi("NvimTreeFolderIcon", { fg = fg_body })
hi("NvimTreeOpenedFolderName", { fg = fg_primary })
hi("NvimTreeOpenedFile", { fg = fg_primary, bold = true })
hi("NvimTreeWinSeparator", { fg = divider, bg = bg_main })
hi("NvimTreeGitIgnored", { link = "Comment" })

-- Barbecue
hi("Barbecue", { bg = bg_main })
-- hi("barbecue_separator", { fg = divider })

-- Lualine
hi("LualineSeparator", { fg = divider })
hi("lualine_a_normal", { bg = bg_inverse })
hi("lualine_c_normal", { link = "StatusLine" })
hi("lualine_c_insert", { link = "StatusLine" })
hi("lualine_c_visual", { link = "StatusLine" })

-- Pulse
if vim.o.background == "dark" then
	hi("PulseDiffNAdd", { bg = s.green_07, fg = fg_body })
	hi("PulseDiffNDelete", { bg = s.red_07, fg = fg_body })
	-- else
	--   hi("PulseDiffNAdd", { fg = s.green_07 })
	--   hi("PulseDiffNDelete", { fg = s.red_07
end

-- Telescope
-- hi("TelescopeNormal", { link = "NormalFloat" })
hi("TelescopeBorder", { fg = divider })
-- hi("TelescopePromptNormal", { link = "NormalFloat" })
-- hi("TelescopePromptBorder", { fg = divider })
-- hi("TelescopeResultsNormal", { link = "NormalFloat" })
-- hi("TelescopeResultsBorder", { fg = divider })
-- hi("TelescopePreviewNormal", { link = "NormalFloat" })
-- hi("TelescopePreviewBorder", { fg = divider })
