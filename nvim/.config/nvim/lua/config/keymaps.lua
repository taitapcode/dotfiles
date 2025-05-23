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
set('n', '<Leader>ha', 'ggVG', optDesc('Select all'))
set('n', '<m-w>', function()
  Snacks.bufdelete()
end, optDesc('Delete Buffer'))
set('n', '<leader>hh', ':nohl<cr>', optDesc('No highlight'))
set('n', '<C-Up>', ':resize -1<CR>', optDesc('Resize up'))
set('n', '<C-Down>', ':resize +1<CR>', optDesc('Resize down'))
set('n', '<C-Left>', ':vertical resize -1<CR>', optDesc('Resize left'))
set('n', '<C-Right>', ':vertical resize +1<CR>', optDesc('Resize right'))
