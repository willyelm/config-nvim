-- Color palette
local color = {
	gray_01 = "#BCBCBC",
	gray_02 = "#A6A6A6",
	gray_03 = "#8F8F8F",
	gray_04 = "#797979",
	gray_05 = "#636363",
	gray_06 = "#4D4D4D",
	gray_07 = "#363636",
	gray_08 = "#202020",
	orange_01 = "#de9084",
	orange_08 = "#4A2D28",
	red_01 = "#ec7e90",
	red_02 = "#d9656e",
	red_07 = "#632f36",
	red_08 = "#361f24",
	blue_01 = "#b6d6fd",
	blue_08 = "#1c4059",
	cyan_01 = "#4fb8cc",
	cyan_08 = "#20424a",
	green_01 = "#c6f1d4",
	green_02 = "#b5e8ca",
	green_07 = "#334537",
	green_08 = "#242a27",
	purple_01 = "#d5bbfa",
	purple_08 = "#402753",
	amber_01 = "#FFE066",
	amber_08 = "#6B5914",
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
				fg_inverse = color.gray_08,
				fg_contrast = color.gray_01,
				fg_link = color.blue_01,
				fg_info = color.cyan_01,
				fg_accent = color.purple_01,
				fg_function = color.purple_05,
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
			fg_inverse = color.gray_01,
			fg_contrast = color.gray_08,
			fg_link = color.blue_08,
			fg_info = color.cyan_08,
			fg_accent = color.purple_08,
			fg_function = color.purple_05,
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
