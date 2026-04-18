vim.pack.add({ 'https://github.com/nvim-mini/mini.keymap' })

local map_multistep = require('mini.keymap').map_multistep
local map_combo = require('mini.keymap').map_combo

local tab_steps = { 'minisnippets_next','minisnippets_expand','pmenu_next' }
map_multistep('i', '<Tab>', tab_steps)

local shifttab_steps = { 'minisnippets_prev', 'pmenu_prev' }
map_multistep('i', '<S-Tab>', shifttab_steps)

-- Hide search highlighting
map_combo({ 'n','i','x','c' }, '<Esc><Esc>', function() vim.cmd('nohlsearch') end)
