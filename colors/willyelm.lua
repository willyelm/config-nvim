-- Reset existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "willyelm"

-- Palette
local s = {
  black          = "#0D0D0D", --"#000000",
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
local bg, bg_subtle, bg_very_subtle, norm, norm_subtle, norm_strong, purple, cyan, green, red, visual, yellow

if vim.o.background == "dark" then
  bg              = "NONE" --s.black
  bg_subtle       = s.lighter_black
  bg_very_subtle  = s.subtle_black
  norm            = s.light_gray
  norm_subtle     = s.medium_gray
  norm_strong     = s.white
  purple          = s.light_purple
  cyan            = s.light_cyan
  green           = s.light_green
  red             = s.light_red
  visual          = s.light_yellow
  yellow          = s.light_yellow
else
  bg              = "NONE" --s.actual_white
  bg_subtle       = s.light_gray
  bg_very_subtle  = s.lightest_gray
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
hi("Normal",       { fg = norm, bg = bg })
hi("Cursor",       { fg = norm, bg = purple })
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
hi("CursorLineNr", { fg = purple, bg = bg_very_subtle })
hi("Visual",       { fg = bg, bg = visual })
hi("VertSplit",    { fg = bg_very_subtle, bg = bg_very_subtle })
hi("WinSeparator", { fg = bg_very_subtle, bg = bg }) -- For modern splits
-- The active status line
hi("StatusLine",   { fg = s.light_gray, bg = bg })
hi("StatusLineNC", { fg = s.medium_gray, bg = bg })
-- Treesitter & Web Dev (TS/JSX/Go)
hi("@tag",                { link = "Function" })
hi("@tag.attribute",      { link = "Normal" })
hi("@tag.delimiter",      { link = "Normal" })
hi("@keyword",            { link = "Keyword" })
hi("@type",               { link = "Type" })
hi("@tag.component.jsx",  { link = "Type" })

-- Pmenu (Floating Windows/Completion)
hi("Pmenu",      { fg = norm, bg = bg_very_subtle })
hi("PmenuSel",   { fg = norm, bg = purple })

-- Sidebar & ASCII UI Components
hi("NvimTreeRootFolder", { fg = purple, bold = true })
hi("NvimTreeIndentMarker", { fg = bg_subtle })
hi("NvimTreeFolderIcon", { fg = norm_strong })
hi("NvimTreeOpenedFolderName", { fg = purple, bold = true })


-- Lualine
hi("lualine_a_normal", { fg = s.black, bg = s.light_purple, bold = true })
hi("lualine_a_insert", { fg = s.black, bg = s.blue, bold = true })
hi("lualine_a_visual", { fg = s.black, bg = s.yellow, bold = true })
hi("lualine_b_normal", { fg = s.white, bg = s.subtle_black })
hi("lualine_b_insert", { fg = s.white, bg = s.subtle_black })
hi("lualine_b_visual", { fg = s.white, bg = s.subtle_black })
hi("lualine_c_normal", { fg = s.light_gray, bg = "NONE" })
hi("lualine_c_insert", { fg = s.light_gray, bg = "NONE" })
hi("lualine_c_visual", { fg = s.light_gray, bg = "NONE" })
hi("lualine_a_inactive", { fg = s.medium_gray, bg = s.subtle_black })
hi("lualine_b_inactive", { fg = s.medium_gray, bg = s.black })
hi("lualine_c_inactive", { fg = s.medium_gray, bg = "NONE" })
hi("lualine_x_normal", { fg = s.light_gray, bg = "NONE" })
hi("lualine_y_normal", { fg = s.white, bg = s.subtle_black })
hi("lualine_z_normal", { fg = s.black, bg = s.light_purple, bold = true })
