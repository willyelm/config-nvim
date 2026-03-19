local color = require("theme.colors")()

return {
	normal = {
		a = { fg = color.fg_inverse, bg = color.bg_inverse, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	insert = {
		a = { fg = color.fg_inverse, bg = color.fg_accent, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	visual = {
		a = { fg = color.fg_inverse, bg = color.fg_positive, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	inactive = {
		a = { bg = "NONE" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
}
