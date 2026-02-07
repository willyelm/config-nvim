vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "willyelm"
-- Colors
local s = {
  black          = "#0D0D0D",
  medium_gray    = "#767676",
  white          = "#F1F1F1",
  actual_white   = "#FFFFFF",
  subtle_black   = "#303030",
  light_black    = "#262626",
  lighter_black  = "#4E4E4E",
  light_gray     = "#A8A8A8",
  lighter_gray   = "#C6C6C6",
  lightest_gray  = "#EEEEEE",
  pink           = "#fb007a",
  dark_red       = "#C30771",
  light_red      = "#E32791",
  orange         = "#D75F5F",
  darker_blue    = "#005F87",
  dark_blue      = "#008EC4",
  blue           = "#20BBFC",
  light_blue     = "#b6d6fd",
  dark_cyan      = "#20A5BA",
  light_cyan     = "#4FB8CC",
  dark_green     = "#ace6bf",
  light_green    = "#c6f1d4",
  dark_purple    = "#af5fd7",
  light_purple   = "#baabdf",
  yellow         = "#e9d999",
  light_yellow   = "#eadead",
  dark_yellow    = "#7d713f",
}
-- Contextual Logic (Dark Mode focus)
local bg, bg_subtle, bg_very_subtle, transparent, divider, norm, norm_subtle, norm_strong, purple, cyan, green, red, visual, yellow

transparent = "NONE"

if vim.o.background == "dark" then
  bg              = s.black 
  bg_subtle       = s.lighter_black
  bg_very_subtle  = s.subtle_black
  divider         = s.subtle_black
  norm            = s.light_gray
  norm_subtle     = s.medium_gray
  norm_strong     = s.white
  purple          = s.light_purple
  cyan            = s.light_cyan
  green           = s.light_green
  red             = s.light_red
  visual          = s.lightest_gray
  yellow          = s.light_yellow
else
  bg              = s.actual_white
  bg_subtle       = s.light_gray
  bg_very_subtle  = s.lightest_gray
  divider         = s.lightest_gray
  norm            = s.light_black
  norm_subtle     = s.medium_gray
  norm_strong     = s.black
  purple          = s.dark_purple
  cyan            = s.dark_cyan
  green           = s.dark_green
  red             = s.dark_red
  visual          = s.dark_purple
  yellow          = s.dark_yellow
end

-- Helper Function
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Standard UI Highlights
hi("Normal",       { fg = norm, bg = transparent })
hi("Cursor",       { fg = norm, bg = norm_strong })
hi("TermCursor",   { fg = s.black, bg = norm_strong })
hi("Comment",      { fg = bg_subtle, italic = true })
hi("String",       { fg = s.light_green })
hi("Constant",     { fg = norm })
hi("Identifier",   { fg = norm_strong })
hi("Function",     { fg = s.light_purple })
hi("Keyword",      { fg = norm_strong, bold = true })
hi("Operator",     { fg = norm, bold = true })
hi("PreProc",      { fg = norm_subtle })
hi("Type",         { fg = s.light_yellow })
hi("Special",      { fg = norm_subtle, italic = true })
hi("Underlined",   { underline = true })
hi("Error",        { fg = s.actual_white, bg = red, bold = true })
hi("Todo",         { fg = purple, underline = true })
hi("Directory",    { fg = norm_strong })
hi("LineNr",       { fg = bg_subtle })
hi("CursorLine",   { bg = bg })
hi("CursorLineNr", { bg = bg })
hi("Visual",       { fg = bg, bg = visual })
hi("VertSplit",    { fg = divider, bg = transparent })
hi("WinSeparator", { fg = divider, bg = transparent })
hi("ColorColumn",  { fg = divider, bg = divider })
hi("WinBar",       { bg = transparent,  sp = divider })
hi("WinBarNC",     { bg = transparent, sp = divider })
hi("StatusLine",   { fg = s.light_gray, bg = transparent, sp = divider, underline = true })
hi("StatusLineNC", { fg = s.medium_gray, bg = "NONE" })
-- Treesitter & Web Dev (TS/JSX/Go)
hi("@tag",                { link = "Function" })
hi("@tag.attribute",      { link = "Normal" })
hi("@tag.delimiter",      { link = "Normal" })
hi("@keyword",            { link = "Keyword" })
hi("@type",               { link = "Type" })
hi("@tag.component.jsx",  { link = "Type" })

-- Pmenu (Floating Windows/Completion)
hi("NormalFloat",           { bg = transparent, fg = norm })
hi("FloatBorder",           { fg = bg_very_subtle, bg = transparent })
hi("Pmenu",                 { fg = norm, bg = s.black }) 
hi("PmenuSel",              { fg = s.black, bg = purple, bold = true })
hi("PmenuSbar",             { bg = s.black })
hi("PmenuThumb",            { bg = bg_very_subtle })
hi("CmpItemAbbrMatch",      { fg = cyan, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = cyan, bold = true })
hi("CmpItemKindFunction",   { fg = purple })
hi("CmpItemKindMethod",     { fg = purple })
hi("CmpItemKindVariable",   { fg = s.blue })
hi("CmpItemKindKeyword",    { fg = norm_strong })
hi("CmpItemKindType",       { fg = s.light_yellow })

-- Tree
hi("NvimTreeNormal",            { fg = norm })
hi("NvimTreeFile",              { fg = norm })
hi("NvimTreeFolderName",        { fg = norm })

hi("NvimTreeRootFolder",        { fg = purple, bold = true })
hi("NvimTreeIndentMarker",      { fg = bg_subtle })
hi("NvimTreeFolderIcon",        { fg = norm })
hi("NvimTreeOpenedFolderName",  { fg = norm_strong, bold = true })
hi("NvimTreeOpenedFile",        { fg = norm_strong, bold = true })
hi("NvimTreeWinSeparator",      { fg = divider, bg = transparent })

-- Barbecue 
hi("Barbecue", { bg = "NONE" })
hi("barbecue_separator",  { fg = divider })

-- Lualine
hi("LualineSeparator",    { fg = divider })
hi("lualine_c_normal",  { link = "StatusLine" })
hi("lualine_c_insert",  { link = "StatusLine" })
hi("lualine_c_visual",  { link = "StatusLine" })

