return {
  {
    'nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gdscript = {},
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { 'utf-16' }
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
        })
      end
    end,
  },
}
