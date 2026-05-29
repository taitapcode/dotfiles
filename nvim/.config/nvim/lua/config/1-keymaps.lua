-- Paste without replacing your clipboard with the deleted text
MAP('x', '<leader>p', [["_dP]], { desc = 'Paste (Black hole)' })

-- Delete without yanking
MAP('n', 'x', [["_x]])
MAP('n', 'X', [["_X]])

-- Selection & Search
MAP('n', '<leader>ha', 'ggVG', { desc = 'Select all' })

-- Restart nvim
MAP('n', '<M-R>', '<cmd>restart<CR>', { desc = 'Restart neovim' })

-- Buffers navigations
MAP('n', 'H', '<cmd>bp<cr>', { desc = 'Buffer previous' })
MAP('n', 'L', '<cmd>bn<cr>', { desc = 'Buffer next' })

MAP_COMBO({ 'n', 'i', 'x', 'c' }, '<Esc><Esc>', function()
  vim.cmd('nohlsearch')
end)

local notify_many_keys = function(key)
  local lhs = string.rep(key, 5)
  local action = function()
    vim.notify('Stop spamming "' .. key .. '" Noob!', 'warn')
  end
  MAP_COMBO({ 'n', 'x' }, lhs, action)
end
notify_many_keys('h')
notify_many_keys('j')
notify_many_keys('k')
notify_many_keys('l')
