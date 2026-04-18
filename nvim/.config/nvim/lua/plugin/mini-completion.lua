vim.pack.add({
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.snippets',
})

require('mini.completion').setup {

}

vim.lsp.config('*', {capabilities = MiniCompletion.get_lsp_capabilities()})
