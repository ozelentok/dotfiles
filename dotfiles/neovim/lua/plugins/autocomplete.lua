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
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end, { 'i', 's', 'c' }),
          ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end, { 'i', 's', 'c' }),
          ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end, { 'i', 's', 'c' }),

          ['<CR>'] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                if cmp.get_selected_entry() then
                  cmp.confirm({ select = false })
                elseif snippy.can_expand_or_advance() then
                  snippy.expand_or_advance()
                else
                  fallback()
                end
              elseif snippy.can_jump(1) then
                snippy.next()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({ select = false })
              else
                fallback()
              end
            end,
            c = function(fallback)
              if cmp.visible() and cmp.get_selected_entry() then
                cmp.confirm({ select = false })
              else
                fallback()
              end
            end,
          }),

          ['<ESC>'] = {
            c = cmp.mapping.close(),
          },

          ['<Tab>'] = cmp.mapping({
            i = function(fallback)
              if snippy.can_jump(1) then
                snippy.next()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if snippy.can_jump(1) then
                snippy.next()
              else
                fallback()
              end
            end,
            c = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
              else
                fallback()
              end
            end,
          }),

          ['<S-Tab>'] = cmp.mapping({
            i = function(fallback)
              if snippy.can_jump(-1) then
                snippy.previous()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if snippy.can_jump(-1) then
                snippy.previous()
              else
                fallback()
              end
            end,
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
              else
                fallback()
              end
            end,
          }),

          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-m>'] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
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
      cmp.setup.cmdline('/', { ---@diagnostic disable-line: undefined-field
        sources = cmp.config.sources({
          { name = 'buffer' }
        })
      })
      cmp.setup.cmdline(':', { ---@diagnostic disable-line: undefined-field
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
