return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  lazy = false,
  keys = function()
    local wk = require('which-key')
    wk.register({ ['<leader>'] = {
      t = {
        name = 'competitest',
      },
    } })

    return {
      { '<leader>ta', '<cmd>CompetiTest add_testcase<cr>', desc = 'Add tesecase' },
      { '<leader>tr', '<cmd>CompetiTest run<cr>', desc = 'Run tesecases' },
      { '<leader>to', '<cmd>CompetiTest show_ui<cr>', desc = 'Show competitest ui' },
      { '<leader>te', ':CompetiTest edit_testcase ', desc = 'Edit testcase' },
      { '<leader>td', ':CompetiTest delete_testcase ', desc = 'Delete testcase' },
    }
  end,
  config = function()
    local test_dir = '.cpt'
    require('competitest').setup({
      multiple_testing = 0,
      maximum_time = 1000,
      compile_command = {
        cpp = { exec = 'g++', args = { '-Wall', '$(FNAME)', '-o', './' .. test_dir .. '/$(FNOEXT)' } },
      },
      run_command = {
        cpp = { exec = './' .. test_dir .. '/$(FNOEXT)' },
      },
      testcases_directory = './' .. test_dir,
      testcases_use_single_file = true,
      testcases_single_file_format = '$(FNOEXT).test',
    })
  end,
}
