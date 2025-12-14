local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local notes_group = augroup('notes_group', { clear = true })

autocmd('BufEnter', {
	desc = 'Say hello world from my first lua plugin',
	group = notes_group,
	callback = function()
		print 'Hello world'
	end,
})
