local c = require("theme.colors")

return {
	normal = {
		a = { fg = c.fg_inverse, bg = c.bg_inverse, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	insert = {
		a = { fg = c.fg_inverse, bg = c.fg_accent, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	visual = {
		a = { fg = c.fg_inverse, bg = c.fg_positive, gui = "bold" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
	inactive = {
		a = { bg = "NONE" },
		b = { bg = "NONE" },
		c = { bg = "NONE" },
	},
}
