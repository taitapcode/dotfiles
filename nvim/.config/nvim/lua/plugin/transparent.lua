vim.pack.add({ 'https://github.com/xiyaowong/transparent.nvim' })

vim.g.transparent_enabled = true
require('transparent').clear_prefix('BufferLine')
require('transparent').setup({
  extra_groups = { 'TabLineFill' },
})
