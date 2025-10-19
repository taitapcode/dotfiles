return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  lazy = false,
  keys = {
    { '<leader>t', group = 'competitest', icon = '󰤑' },
    { '<leader>ta', '<cmd>CompetiTest add_testcase<cr>', desc = 'Add tesecase' },
    { '<leader>tr', '<cmd>CompetiTest run<cr>', desc = 'Run tesecases' },
    { '<leader>to', '<cmd>CompetiTest show_ui<cr>', desc = 'Show competitest ui' },
    { '<leader>te', ':CompetiTest edit_testcase ', desc = 'Edit testcase' },
    { '<leader>td', ':CompetiTest delete_testcase ', desc = 'Delete testcase' },
  },
  opts = function(_, opts)
    local test_dir = '.cpt'
    opts.multiple_testing = 0
    opts.maximum_time = 1000
    opts.testcases_directory = test_dir
    opts.testcases_use_single_file = false
    opts.testcases_single_file_format = '$(FNOEXT).test'
    opts.compile_command = {
      cpp = { exec = 'g++', args = { '-Wall', '-DEBUG', '$(FNAME)', '-o', './' .. test_dir .. '/$(FNOEXT)' } },
    }
    opts.run_command = {
      cpp = { exec = './' .. test_dir .. '/$(FNOEXT)' },
    }
  end,
}
