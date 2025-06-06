local set = vim.keymap.set
local function optDesc(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

-- Resize split windows with Alt + hjkl
set('n', '<m-k>', ':resize -1<CR>', optDesc('Resize up'))
set('n', '<m-j>', ':resize +1<CR>', optDesc('Resize down'))
set('n', '<m-l>', ':vertical resize -1<CR>', optDesc('Resize left'))
set('n', '<m-h>', ':vertical resize +1<CR>', optDesc('Resize right'))

-- Disable auto save replaced text to clipboard when pasting text
set('x', '<leader>p', [["_dP]], optDesc('Paste without replacing clipboard'))

-- Disable yank on delete
set('n', 'x', [["_x]])
set('n', 'X', [["_X]])

set('n', '<Leader>ha', 'ggVG', optDesc('Select all'))
set('n', '<m-w>', function()
  Snacks.bufdelete()
end, optDesc('Delete Buffer'))
set('n', '<leader>hh', ':nohl<cr>', optDesc('No highlight'))
