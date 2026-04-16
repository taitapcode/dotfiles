vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- Delete Buffer
map('n', '<m-w>', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })

-- Files Picker
map('n', '<leader><space>', function() Snacks.picker.files() end, { desc = 'Find Files' })
map('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent Files' })
