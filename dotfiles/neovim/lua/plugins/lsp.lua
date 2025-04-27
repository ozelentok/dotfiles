vim.lsp.set_log_level('OFF')

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ray-x/lsp_signature.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>v', vim.lsp.buf.format,      noremap = true, desc = 'LSP Format' },
      { '<leader>c', vim.lsp.buf.code_action, noremap = true, desc = 'LSP Code Action' },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local on_lsp_attach = function(_, bufnr)
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
        require('lsp_signature').on_attach({ hint_enable = false, hi_parameter = 'MoreMsg' }, bufnr)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.lua_ls.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT', },
            diagnostics = { globals = { 'vim', 'vifm', 'Snacks' } },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                '${3rd}/luv/library'
              }
            },
            telemetry = { enable = false },
            format = {
              enable = true,
            }
          }
        }
      }

      lspconfig.html.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.jsonls.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.cssls.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.clangd.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.pyright.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.ruff.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.eslint.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.cmake.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.bashls.setup({
        filetypes = { 'sh', 'zsh' },
        on_attach = on_lsp_attach,
        capabilities = capabilities
      })
      lspconfig.arduino_language_server.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.openscad_lsp.setup({
        cmd = { 'openscad-lsp', '--stdio', '--fmt-style', 'LLVM' },
        on_attach = on_lsp_attach,
        capabilities = capabilities,
      })
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    keys = {
      { '<C-,>', function() require('lsp_signature').toggle_float_win() end, mode = 'i', noremap = true },
    }
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function()
      local null_ls = require('null-ls')
      local trim_whitespace = {
        name = 'trim_whitespace',
        method = null_ls.methods.FORMATTING,
        filetypes = {},
        generator = null_ls.formatter({
          command = 'awk',
          args = { '{ sub(/[ \t]+$/, ""); print }' },
          to_stdin = true,
        }),
      }

      return {
        sources = {
          null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'sqlite' } }),
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.tidy,
          trim_whitespace,
        }
      }
    end,
  },

  -- Incremental LSP Renaming
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup({})
    end,
  }
}
