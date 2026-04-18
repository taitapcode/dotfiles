vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })

require('mini.files').setup({
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

map('n', '<leader>e', function() MiniFiles.open(vim.api.nvim_buf_get_name(0), true) end, { desc = 'Open mini.files' })
map('n', '<Esc>', MiniFiles.close, { desc = 'Close mini.files' })
