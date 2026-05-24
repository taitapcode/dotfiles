vim.pack.add({ 'https://github.com/alexghergh/nvim-tmux-navigation' })

local tmux_nav = require('nvim-tmux-navigation')
tmux_nav.setup({
  -- disable_when_zoomed = true -- defaults to false
})

MAP('n', '<C-h>', tmux_nav.NvimTmuxNavigateLeft)
MAP('n', '<C-j>', tmux_nav.NvimTmuxNavigateDown)
MAP('n', '<C-k>', tmux_nav.NvimTmuxNavigateUp)
MAP('n', '<C-l>', tmux_nav.NvimTmuxNavigateRight)
MAP('n', '<C-\\>', tmux_nav.NvimTmuxNavigateLastActive)
