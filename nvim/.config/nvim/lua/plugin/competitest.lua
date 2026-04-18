vim.pack.add({
  'https://github.com/xeluxee/competitest.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
})

local test_dir = '.cpt'
require('competitest').setup({
  multiple_testing = 0,
  maximum_time = 1000,
  testcases_directory = test_dir,
  testcases_use_single_file = false,
  testcases_single_file_format = '$(FNOEXT).test',

  compile_command = {
    cpp = {
      exec = 'g++',
      args = { '-std=c++17', '-O2', '-Wall', '-Wextra', '-DEBUG', '$(FNAME)', '-o', './' .. test_dir .. '/$(FNOEXT)' },
    },
  },

  run_command = {
    cpp = { exec = './' .. test_dir .. '/$(FNOEXT)' },
  },
})

map('n', '<leader>ta', '<cmd>CompetiTest add_testcase<cr>', { desc = 'Add Testcase' })
map('n', '<leader>tr', '<cmd>CompetiTest run<cr>', { desc = 'Run Testcases' })
map('n', '<leader>to', '<cmd>CompetiTest show_ui<cr>', { desc = 'Show UI' })

-- Loop for Edit and Delete
for i = 0, 9 do
  map('n', '<leader>te' .. i, '<cmd>CompetiTest edit_testcase ' .. i .. '<cr>', { desc = 'Edit testcase ' .. i })
  map('n', '<leader>td' .. i, '<cmd>CompetiTest delete_testcase ' .. i .. '<cr>', { desc = 'Delete testcase ' .. i })
end
