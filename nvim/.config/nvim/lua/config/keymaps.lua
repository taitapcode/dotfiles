local set = vim.keymap.set
local function optDesc(desc)
  return {
    noremap = true,
    silent = true,
    desc = desc,
  }
end

set('n', '<Leader>a', 'ggVG', optDesc('Select all'))
set('n', '<m-w>', LazyVim.ui.bufremove, optDesc('Delete Buffer'))
set('n', '<leader>h', ':nohl<cr>', optDesc('No highlight'))
set('x', '<leader>p', [["_dP]])
