vim.pack.add({ 'https://github.com/alexghergh/nvim-tmux-navigation' })

local tmux_nav = require('nvim-tmux-navigation')
tmux_nav.setup {
  -- disable_when_zoomed = true -- defaults to false
}

map('n', "<C-h>", tmux_nav.NvimTmuxNavigateLeft)
map('n', "<C-j>", tmux_nav.NvimTmuxNavigateDown)
map('n', "<C-k>", tmux_nav.NvimTmuxNavigateUp)
map('n', "<C-l>", tmux_nav.NvimTmuxNavigateRight)
map('n', "<C-\\>", tmux_nav.NvimTmuxNavigateLastActive)
