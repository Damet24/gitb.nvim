local utils = require("gitb_nvim.utils")

-- Defaults
return {
	enabled = false,

	highlights = {
		author = { fg = utils.fg_of_group("Comment"), bold = true },
		date = { fg = utils.fg_of_group("Identifier"), italic = true },
		msg = { fg = utils.fg_of_group("Normal") },
	},

	popup = {
		max_width = 80,
		max_height = 15,
		border = "rounded",
	},
}
