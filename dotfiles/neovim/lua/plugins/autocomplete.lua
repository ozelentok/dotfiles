return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dcampos/cmp-snippy',
      'windwp/nvim-autopairs',
    },
    config = function()
      local cmp = require('cmp')
      local snippy = require('snippy')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.setup({ ---@diagnostic disable-line: redundant-parameter
        snippet = {
          expand = function(args)
            snippy.expand_snippet(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping(function()
            cmp.select_prev_item()
          end, { 'i', 's', 'c' }),
          ['<C-n>'] = cmp.mapping(function()
            cmp.select_next_item()
          end, { 'i', 's', 'c' }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if snippy.can_jump(-1) then
              snippy.previous()
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'snippy' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          {
            name = 'path',
            option = {
              label_trailing_slash = false,
              get_cwd = function()
                return vim.fn.getcwd(vim.fn.winnr())
              end,
            }
          },
        })
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'buffer' }
        })
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } }
        })
      })
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  'dcampos/nvim-snippy',
  'honza/vim-snippets',
}
