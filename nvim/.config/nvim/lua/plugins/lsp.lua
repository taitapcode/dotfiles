return {
  {
    'nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gdscript = {},
        fish_lsp = {},
        qmlls = {},
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { 'utf-16' }
        end,

        cssls = function(_, opts)
          opts.settings = {
            css = {
              validate = false, -- Disable CSS validation for tailwindcss
            },
          }
        end,

        pyright = function(_, opts)
          opts.capabilities = {
            window = {
              workDoneProgress = false, -- Disables the progress bar for pyright
            },
          }
        end,
      },
    },
  },

  {
    'mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'html-lsp',
          'emmet-language-server',
          'css-lsp',
          'cssmodules-language-server',
          'css-variables-language-server',
          'fish-lsp',
        })
      end
    end,
  },
}
