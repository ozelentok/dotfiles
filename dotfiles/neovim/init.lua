require('init/base')
if require('init/plugins') then
	require('init/colors')
	require('init/lualine')
	require('init/mappings')
	require('init/lsp')
	require('init/etc')
end
