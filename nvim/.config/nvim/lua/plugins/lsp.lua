return {
  {
    'nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = false },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { 'utf-16' }
        end,
      },
    },
  },

  {
    'mason.nvim',
    version = '^1.0.0',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'html-lsp',
          'emmet-language-server',
          'css-lsp',
          'cssmodules-language-server',
          'css-variables-language-server',
        })
      end
    end,
  },

  {
    'mason-lspconfig.nvim',
    version = '^1.0.0',
  },
}
