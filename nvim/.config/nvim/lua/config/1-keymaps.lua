-- Paste without replacing your clipboard with the deleted text
MAP('x', '<leader>p', [["_dP]], { desc = 'Paste (Black hole)' })

-- Delete without yanking
MAP('n', 'x', [["_x]])
MAP('n', 'X', [["_X]])

-- Selection & Search
MAP('n', '<leader>ha', 'ggVG', { desc = 'Select all' })

-- Restart nvim
MAP('n', '<M-R>', '<cmd>restart<CR>', { desc = 'Restart neovim' })

-- Buffers navigations
MAP('n', 'H', '<cmd>bp<cr>', { desc = 'Buffer previous' })
MAP('n', 'L', '<cmd>bn<cr>', { desc = 'Buffer next' })

MAP_COMBO({ 'n', 'i', 'x', 'c' }, '<Esc><Esc>', function()
  vim.cmd('nohlsearch')
end)

-- Move by visible lines safely unless given a count
MAP({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
MAP({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- System Clipboard mappings matching your config layout
MAP({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
MAP('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
MAP('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Reselect last modified context region
MAP('n', 'gV', '"g`[" . strpart(getregtype(), 0, 1) . "g`]"', { expr = true, desc = 'Visually select changed text' })
MAP('x', 'g/', '<Esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Save hooks mapped to Ctrl+S
MAP('n', '<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' })
MAP({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

-- Window actions via Ctrl + hjkl
MAP('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
MAP('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
MAP('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
MAP('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- Sizing hooks via Ctrl + Direction arrows
MAP('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, desc = 'Decrease window width' })
MAP('n', '<C-Down>', '"<Cmd>resize -"          . v:count1 . "<CR>"', { expr = true, desc = 'Decrease window height' })
MAP('n', '<C-Up>', '"<Cmd>resize +"          . v:count1 . "<CR>"', { expr = true, desc = 'Increase window height' })
MAP('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, desc = 'Increase window width' })

-- Meta/Alt navigational binds across modes
MAP('c', '<M-h>', '<Left>', { silent = false, desc = 'Left' })
MAP('c', '<M-l>', '<Right>', { silent = false, desc = 'Right' })
MAP('i', '<M-h>', '<Left>', { noremap = false, desc = 'Left' })
MAP('i', '<M-j>', '<Down>', { noremap = false, desc = 'Down' })
MAP('i', '<M-k>', '<Up>', { noremap = false, desc = 'Up' })
MAP('i', '<M-l>', '<Right>', { noremap = false, desc = 'Right' })
MAP('t', '<M-h>', '<Left>', { desc = 'Left' })
MAP('t', '<M-j>', '<Down>', { desc = 'Down' })
MAP('t', '<M-k>', '<Up>', { desc = 'Up' })
MAP('t', '<M-l>', '<Right>', { desc = 'Right' })

-- Dot-repeatable lines insertions calling helper functions
MAP('n', 'gO', 'v:lua.KEYMAP_PUT_EMPTY_LINE(v:true)', { expr = true, desc = 'Put empty line above' })
MAP('n', 'go', 'v:lua.KEYMAP_PUT_EMPTY_LINE(v:false)', { expr = true, desc = 'Put empty line below' })

-- =============================================================================
-- System Parameter Option Toggles (Prefix: \)
-- =============================================================================
MAP_TOGGLE(
  'b',
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  "Toggle 'background'"
)
MAP_TOGGLE('c', '<Cmd>setlocal cursorline! cursorline?<CR>', "Toggle 'cursorline'")
MAP_TOGGLE('C', '<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>', "Toggle 'cursorcolumn'")
MAP_TOGGLE(
  'h',
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  'Toggle search highlight'
)
MAP_TOGGLE('i', '<Cmd>setlocal ignorecase! ignorecase?<CR>', "Toggle 'ignorecase'")
MAP_TOGGLE('l', '<Cmd>setlocal list! list?<CR>', "Toggle 'list'")
MAP_TOGGLE('n', '<Cmd>setlocal number! number?<CR>', "Toggle 'number'")
MAP_TOGGLE('r', '<Cmd>setlocal relativenumber! relativenumber?<CR>', "Toggle 'relativenumber'")
MAP_TOGGLE('s', '<Cmd>setlocal spell! spell?<CR>', "Toggle 'spell'")
MAP_TOGGLE('w', '<Cmd>setlocal wrap! wrap?<CR>', "Toggle 'wrap'")
MAP_TOGGLE('d', '<Cmd>lua KEYMAP_TOGGLE_DIAGNOSTIC()<CR>', 'Toggle diagnostic')
