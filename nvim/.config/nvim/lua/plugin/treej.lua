vim.pack.add({ 'https://github.com/wansmer/treesj' })
require('treesj').setup({
  use_default_keymaps = false,
  max_join_length = 200,
})

map('n', '<leader>m', require('treesj').toggle)
