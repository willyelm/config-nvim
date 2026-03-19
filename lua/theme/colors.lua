-- Color palette
local color = {
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
	amber_01 = "#FFE066",
	amber_08 = "#6B5914",
}

-- Semantic colors based on background
local semantic = vim.o.background == "dark"
		and {
			bg_main = "NONE",
			bg_inverse = color.gray_01,
			bg_active = color.gray_08,
			bg_visual = color.gray_02,
			bg_search = color.amber_01,
			bg_positive = color.green_08,
			bg_negative = color.red_08,
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
			divider = color.gray_07,
		}
	or {
		bg_main = "NONE",
		bg_inverse = color.gray_08,
		bg_active = color.gray_02,
		bg_visual = color.gray_08,
		bg_search = color.amber_01,
		bg_positive = color.green_01,
		bg_negative = color.red_01,
		fg_primary = color.gray_08,
		fg_body = color.gray_08,
		fg_secondary = color.gray_06,
		fg_muted = color.gray_05,
		fg_inverse = color.gray_01,
		fg_contrast = color.gray_08,
		fg_link = color.blue_08,
		fg_info = color.cyan_08,
		fg_accent = color.purple_08,
		fg_function = color.purple_05,
		fg_string = color.orange_08,
		fg_warning = color.amber_08,
		fg_positive = color.green_07,
		fg_negative = color.red_07,
		divider = color.gray_04,
	}

-- Merge palette and semantic colors into single table
local palette = {}
for k, v in pairs(color) do
	palette[k] = v
end
for k, v in pairs(semantic) do
	palette[k] = v
end

return palette
