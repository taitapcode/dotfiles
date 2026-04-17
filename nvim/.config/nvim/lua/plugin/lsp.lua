vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim'
})

require('mason').setup()
require('mason-lspconfig').setup({
  automatic_enable = false,
  ensure_installed = { 'lua_ls', 'fish_lsp', 'clangd' }
})

vim.lsp.enable({ 'gdscript', 'lua_ls', 'fish_lsp', 'clangd' })

vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities()
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { global = { 'vim', 'require' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false }
    }
  }
})
