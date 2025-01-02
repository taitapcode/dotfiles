local set = vim.keymap.set
local function optDesc(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

set('x', '<leader>p', [["_dP]])
set('n', 'x', [["_x]])
set('n', 'X', [["_X]])
set('n', '<Leader>a', 'ggVG', optDesc('Select all'))
set('n', '<m-w>', function()
  Snacks.bufdelete()
end, optDesc('Delete Buffer'))
set('n', '<leader>h', ':nohl<cr>', optDesc('No highlight'))
