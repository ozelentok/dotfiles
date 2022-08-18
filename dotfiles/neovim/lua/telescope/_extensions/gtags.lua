local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
	error('This plugins requires nvim-telescope/telescope.nvim')
end

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local Path = require('plenary.path')

local generate_gtags_picker = function(command, title)
	return function(opts)
		local tag = opts.search or vim.fn.expand('<cword>')
		local proc = io.popen(string.format('global -q %s --result=ctags-mod -- "%s"', command, tag))
		local results = {}
		for l in proc:lines() do
			local _, _, path, line_number, text = string.find(l, '([^\t]+)\t(%d+)\t(.*)')
			table.insert(results, { path, tonumber(line_number, 10), text })
		end
		proc.close()

		local finder = finders.new_table({
			results = results,
			entry_maker = function(r)
				local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())
				local abs_path = Path:new({ cwd, r[1] }):absolute()
				return {
					filename = r[1],
					path = abs_path,
					ordinal = r[1],
					lnum = r[2],
					col = string.find(r[3], tag) - 1,
					display = string.format('%s:%s\t%s', r[1], r[2], r[3])
				}
			end,
		})
		pickers.new(opts, {
			prompt_title = title,
			finder = finder,
			previewer = conf.grep_previewer(opts),
		}):find()
	end
end

return telescope.register_extension {
	exports = {
		def = generate_gtags_picker('-d', 'Gtags Definitions'),
		ref = generate_gtags_picker('-r', 'Gtags References')
	}
}
