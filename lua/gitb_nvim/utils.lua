local M = {}

function M.set_highlight(name, opts)
	vim.api.nvim_set_hl(0, name, {
		fg = opts.fg,
		bold = opts.bold or false,
		italic = opts.italic or false,
	})
end

function M.fg_of_group(group)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
	if ok and hl.fg then
		return string.format("#%06x", hl.fg)
	end
	return nil
end

function M.cache_key(file, line)
	return file .. ":" .. line
end

return M
