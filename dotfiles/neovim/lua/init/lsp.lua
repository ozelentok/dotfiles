local lspconfig = require('lspconfig')
local cmp = require('cmp')
local snippy = require('snippy')

cmp.setup({
	snippet = {
		expand = function(args)
			snippy.expand_snippet(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if snippy.can_expand_or_advance() then
				snippy.expand_or_advance()
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if snippy.can_jump(-1) then
				snippy.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {'i', 's'}),
	},
	sources = cmp.config.sources({
		{name = 'snippy'},
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'path'},
	})
})

local on_lsp_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	require('lsp_signature').on_attach({hint_enable = false, hi_parameter = 'MoreMsg'}, bufnr)
end

local lua_rpath = vim.split(package.path, ';')
table.insert(lua_rpath, 'lua/?.lua')
table.insert(lua_rpath, 'lua/?/init.lua')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.sumneko_lua.setup{
	cmd = {'/usr/bin/lua-language-server', '-E', '/usr/lib/lua-language-server/main.lua'};
	on_attach = on_lsp_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {version = 'LuaJIT', path = lua_rpath},
			diagnostics = {globals = {'vim'}},
			workspace = {library = vim.api.nvim_get_runtime_file('', true)},
			telemetry = {enable = false},
		}
	}
}
lspconfig.pyright.setup({on_attach = on_lsp_attach, capabilities = capabilities})
lspconfig.html.setup({on_attach = on_lsp_attach, capabilities = capabilities})
lspconfig.jsonls.setup({on_attach = on_lsp_attach, capabilities = capabilities})
lspconfig.cssls.setup({on_attach = on_lsp_attach, capabilities = capabilities})
lspconfig.clangd.setup({on_attach = on_lsp_attach, capabilities = capabilities})
