vim.lsp.set_log_level('OFF')

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>v', vim.lsp.buf.format,      noremap = true, desc = 'LSP Format' },
      { '<leader>c', vim.lsp.buf.code_action, noremap = true, desc = 'LSP Code Action' },
    },
    config = function()
      vim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
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
      })

      vim.lsp.enable('clangd')
      vim.lsp.enable('pyright')
      vim.lsp.enable('ruff')
      vim.lsp.enable('eslint')
      vim.lsp.enable('cmake')
      vim.lsp.enable('html')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('cssls')
      vim.lsp.enable('arduino_language_server')
      vim.lsp.enable('bashls')
      vim.lsp.enable('openscad_lsp')
      vim.lsp.config('bashls', { filetypes = { 'bash', 'sh', 'zsh' } })
      vim.lsp.config('openscad_lsp', { cmd = { 'openscad-lsp', '--stdio', '--fmt-style', 'LLVM' } })
    end
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
