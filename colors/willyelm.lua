vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "willyelm"
-- Colors
local s = {
	black = "#000000",
	white = "#FEFEFE",
	gray_01 = "#F1F1F1",
	gray_02 = "#EEEEEE",
	gray_03 = "#C6C6C6",
	gray_04 = "#A8A8A8",
	gray_05 = "#767676",
	gray_06 = "#404040",
	gray_07 = "#303030",
	gray_08 = "#202020",
	gray_09 = "#0D0D0D",
	orange = "#ef8875",
	red_01 = "#ec7e90",
	red_10 = "#7d2c34",
	blue_01 = "#b6d6fd",
	blue_10 = "#008EC4",
	cyan_01 = "#4fb8cc",
	cyan_10 = "#20434b",
	green_01 = "#c6f1d4",
	green_10 = "#333f36",
	purple_01 = "#d5bbfa",
	purple_10 = "#442a58",
	yellow_01 = "#eadead",
	yellow_10 = "#7d713f",
}
-- Semantic variables
local bg_main, bg_active, bg_visual, bg_inverse, bg_positive, bg_negative
local fg_body, fg_primary, fg_secondary, fg_muted, fg_inverse, fg_contrast
local fg_positive, fg_negative, fg_warning, fg_info, fg_accent, fg_string, fg_link
local divider

if vim.o.background == "dark" then
	bg_main = "NONE"
	bg_active = s.gray_08
	bg_visual = s.gray_02
	bg_inverse = s.white
	bg_positive = s.green_10
	bg_negative = s.red_10
	fg_body = s.gray_03
	fg_primary = s.gray_01
	fg_secondary = s.gray_05
	fg_muted = s.gray_06
	fg_inverse = s.gray_09
	fg_contrast = s.white
	fg_positive = s.green_01
	fg_negative = s.red_01
	fg_warning = s.yellow_01
	fg_info = s.cyan_01
	fg_accent = s.purple_01
	fg_string = s.orange
	fg_link = s.blue_01
	divider = s.gray_07
else
	bg_main = "NONE"
	bg_active = s.gray_02
	bg_visual = s.purple_10
	bg_inverse = s.black
	bg_positive = s.green_01
	bg_negative = s.red_01
	fg_body = s.gray_08
	fg_primary = s.gray_09
	fg_secondary = s.gray_05
	fg_muted = s.gray_04
	fg_inverse = s.white
	fg_contrast = s.black
	fg_positive = s.green_10
	fg_negative = s.red_10
	fg_warning = s.yellow_10
	fg_info = s.cyan_10
	fg_accent = s.purple_10
	fg_string = s.orange
	fg_link = s.blue_10
	divider = s.gray_02
end

-- Helper Function
local function hi(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Standard UI Highlights
hi("Normal", { fg = fg_body, bg = bg_main })
hi("Cursor", { fg = fg_body, bg = bg_inverse })
hi("TermCursor", { fg = fg_primary, bg = fg_primary })
hi("Comment", { fg = fg_muted, italic = true })
hi("String", { fg = fg_string })
hi("Number", { fg = fg_warning })
hi("Float", { link = "Number" })
hi("Boolean", { link = "Number" })
hi("Constant", { fg = fg_body })
hi("Identifier", { fg = fg_primary })
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
hi("VertSplit", { fg = divider, bg = bg_main })
hi("WinSeparator", { fg = divider, bg = bg_main })
hi("ColorColumn", { fg = divider, bg = divider })
hi("WinBar", { bg = bg_main, sp = divider })
hi("WinBarNC", { bg = bg_main, sp = divider })
hi("StatusLine", { fg = fg_muted, bg = bg_main, sp = divider })
hi("StatusLineNC", { fg = fg_secondary, bg = bg_main })

-- TypeScript
hi("typescriptTypeReference", { link = "Type" })
hi("typescriptObjectLabel", { link = "Normal" })
hi("typescriptVariable", { link = "Keyword" })

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
hi("NormalFloat", { bg = bg_main, fg = fg_body })
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
hi("NvimTreeRootFolder", { bold = true, underline = true })
hi("NvimTreeIndentMarker", { fg = fg_muted })
hi("NvimTreeFolderIcon", { fg = fg_body })
hi("NvimTreeOpenedFolderName", { fg = fg_primary, bold = true })
hi("NvimTreeOpenedFile", { fg = fg_primary, bold = true })
hi("NvimTreeWinSeparator", { fg = divider, bg = bg_main })
hi("NvimTreeGitIgnored", { link = "Comment" })

-- Barbecue
hi("Barbecue", { bg = bg_main })
hi("barbecue_separator", { fg = divider })

-- Lualine
hi("LualineSeparator", { fg = divider })
hi("lualine_a_normal", { bg = bg_inverse })
hi("lualine_c_normal", { link = "StatusLine" })
hi("lualine_c_insert", { link = "StatusLine" })
hi("lualine_c_visual", { link = "StatusLine" })

-- Aerial
hi("AerialNormal", { fg = fg_body })
hi("AerialError", { fg = fg_negative })
hi("AerialWarning", { fg = fg_warning })
hi("AerialInformation", { fg = fg_info })
hi("AerialHint", { fg = fg_accent })

-- Telescope
hi("TelescopeNormal", { bg = bg_main })
