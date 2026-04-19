-- Paste without replacing your clipboard with the deleted text
map('x', '<leader>p', [["_dP]], { desc = 'Paste (Black hole)' })

-- Delete without yanking
map('n', 'x', [["_x]])
map('n', 'X', [["_X]])

-- Selection & Search
map('n', '<leader>ha', 'ggVG', { desc = 'Select all' })

-- Restart nvim
map('n', '<leader>r', '<cmd>restart<CR>', { desc = 'Restart neovim' })

-- Buffers
map('n', 'H', '<cmd>bp<cr>', { desc = 'Buffer previous' })
map('n', 'L', '<cmd>bn<cr>', { desc = 'Buffer next' })
