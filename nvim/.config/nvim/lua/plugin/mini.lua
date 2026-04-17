vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
require('mini.move').setup()
require('mini.pairs').setup()

require('mini.basics').setup({
  options = {
    extra_ui = true,
  },
  mappings = {
    basic = true,
    windows = true,
    move_with_alt = true,
  }
})

require('mini.cmdline').setup({
  autocomplete = {
    enable = true,
    delay = 200,
  }
})

local mini_files = require('mini.files')
mini_files.setup({
  options = {
    use_as_default_explorer = true
  },
  mappings = {
    go_in = '',
    go_out = '',
    go_in_plus = 'l',
    go_out_plus = 'h',
    synchronize = '<Return>',
  },
  content = {
    filter = function(fs_entry)
      local hidden_folders = {
        '.git',
        'node_modules',
        'dist',
        '.next',
        '.cache'
      }
      for _, folder_name in ipairs(hidden_folders) do
        if fs_entry.name == folder_name then
          return false
        end
      end
      return true
    end,
  },
  windows = {
    preview = true,
    width_focus = 30,
    width_nofocus = 25,
    width_preview = 40,
  },
})

map('n', '<leader>e', function() mini_files.open(vim.api.nvim_buf_get_name(0), true) end, { desc = 'Open mini.files' })
map('n', '<Esc>', mini_files.close, { desc = 'Close mini.files' })

local mini_trailspace = require('mini.trailspace')
mini_trailspace.setup()
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function() mini_trailspace.trim() end,
  desc = "Auto-remove trailing whitespace on save",
})
