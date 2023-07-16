vim.lsp.set_log_level('OFF')

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ray-x/lsp_signature.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>v', vim.lsp.buf.format, noremap = true },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local on_lsp_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('lsp_signature').on_attach({ hint_enable = false, hi_parameter = 'MoreMsg' }, bufnr)
      end

      local lua_rpath = vim.split(package.path, ';')
      table.insert(lua_rpath, 'lua/?.lua')
      table.insert(lua_rpath, 'lua/?/init.lua')

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities = vim.tbl_extend('force', capabilities, { offsetEncoding = 'utf-8' })
      lspconfig.lua_ls.setup {
        on_attach = on_lsp_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT', path = lua_rpath },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
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
      lspconfig.eslint.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.openscad_lsp.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
      lspconfig.arduino_language_server.setup({ on_attach = on_lsp_attach, capabilities = capabilities })
    end
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      local null_ls = require('null-ls')
      return {
        sources = {
          null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { '--dialect', 'sqlite' } }),
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.formatting.json_tool,
          null_ls.builtins.formatting.yapf,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.tidy,
          null_ls.builtins.formatting.trim_whitespace,
        }
      }
    end,
  },

  -- Incremental LSP Renaming
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
    end,
  }
}
