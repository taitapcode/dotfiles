require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },
    fish = { 'fish_indent' },
    json = { 'prettierd' },
    jsonc = { 'prettierd' },
    nix = { 'nixfmt' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

MAP({ 'n', 'v', 'i' }, '<M-s>', function()
  require('conform').format({
    lsp_fallback = 'fallback',
    async = false,
    timeout_ms = 500,
  })
end, { desc = 'Format file or range (visual)' })
