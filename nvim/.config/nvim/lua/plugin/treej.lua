vim.pack.add({ 'https://github.com/wansmer/treesj' })
require('treesj').setup()

map('n', '<leader>m', require('treesj').toggle)
