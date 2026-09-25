-- Color palette
local color = {
  gray_01 = "#d9d9d9",
  gray_02 = "#A6A6A6",
  gray_03 = "#8F8F8F",
  gray_04 = "#797979",
  gray_05 = "#636363",
  gray_06 = "#4D4D4D",
  gray_07 = "#363636",
  gray_08 = "#202020",
  red_01 = "#ff7b7b",
  red_02 = "#e86060",
  red_07 = "#5e2626",
  red_08 = "#361c1c",
  blue_01 = "#b6d6fd",
  blue_08 = "#1c4059",
  green_01 = "#bbf0d5",
  green_02 = "#8bdab3",
  green_07 = "#273a30",
  green_08 = "#1e2924",
  magenta_01 = "#f59cc4",
  magenta_03 = "#d86496",
  magenta_06 = "#c2477f",
  magenta_08 = "#5c1f39",
  amber_01 = "#ffd04d",
  amber_08 = "#6b4d00",
}

local function get_semantic()
  return vim.o.background == "dark"
      and {
        bg_main = "NONE",
        bg_inverse = color.gray_01,
        bg_active = color.gray_07,
        bg_action = color.gray_08,
        bg_visual = color.gray_02,
        bg_search = color.amber_01,
        bg_positive = color.green_08,
        bg_negative = color.red_08,
        bg_modified = color.amber_08,
        fg_primary = color.gray_01,
        fg_body = color.gray_02,
        fg_secondary = color.gray_05,
        fg_muted = color.gray_06,
        fg_faint = color.gray_07,
        fg_inverse = color.gray_08,
        fg_contrast = color.gray_01,
        fg_link = color.blue_01,
        fg_info = color.blue_01,
        fg_accent = color.magenta_01,
        fg_function = color.gray_01,
        fg_string = color.green_01,
        fg_warning = color.amber_01,
        fg_positive = color.green_01,
        fg_negative = color.red_01,
        divider = color.gray_06,
      }
    or {
      bg_main = "NONE",
      bg_inverse = color.gray_08,
      bg_active = color.gray_02,
      bg_action = color.gray_01,
      bg_visual = color.gray_08,
      bg_search = color.amber_01,
      bg_positive = color.green_01,
      bg_negative = color.red_01,
      bg_modified = color.amber_01,
      fg_primary = color.gray_08,
      fg_body = color.gray_07,
      fg_secondary = color.gray_06,
      fg_muted = color.gray_05,
      fg_faint = color.gray_06,
      fg_inverse = color.gray_01,
      fg_contrast = color.gray_08,
      fg_link = color.blue_08,
      fg_info = color.blue_08,
      fg_accent = color.magenta_08,
      fg_function = color.magenta_06,
      fg_string = color.green_08,
      fg_warning = color.amber_08,
      fg_positive = color.green_08,
      fg_negative = color.red_08,
      divider = color.gray_04,
    }
end

return function()
  local merged = {}
  for k, v in pairs(color) do
    merged[k] = v
  end
  for k, v in pairs(get_semantic()) do
    merged[k] = v
  end
  return merged
end
