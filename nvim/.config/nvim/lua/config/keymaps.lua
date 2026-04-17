_G.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Paste without replacing your clipboard with the deleted text
map('x', '<leader>p', [["_dP]], { desc = 'Paste (Black hole)' })

-- Delete without yanking
map('n', 'x', [["_x]])
map('n', 'X', [["_X]])

-- Selection & Search
map('n', '<leader>ha', 'ggVG', { desc = 'Select all' })
map('n', '<leader>hh', ':set hlsearch!<cr>', { desc = 'Toggle highlight search' })

-- Handle Smart Space: (|) -> ( | )
local function smart_space()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local left = line:sub(col, col)
  local right = line:sub(col + 1, col + 1)

  -- If cursor is between (), [], or {}, insert two spaces and move left
  if left:match('[%(%{%[]') and right:match('[%)%}%]]') then
    return '<Space><Space><Left>'
  end
  return '<Space>'
end

-- Handle Smart Backspace: ( | ) -> ()
local function smart_backspace()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  local char_before = line:sub(col, col)
  local char_after = line:sub(col + 1, col + 1)
  local context_wide = line:sub(col - 1, col + 2) -- e.g., "(  )"

  if context_wide:match('%(  %)') or context_wide:match('%[  %]') or context_wide:match('%{  %}') then
    return "<BS><Del>"
  end

  local pairs = { ['('] = ')', ['['] = ']', ['{'] = '}', ['"'] = '"', ["'"] = "'" }
  if pairs[char_before] == char_after then
    return "<BS><Del>"
  end

  return "<BS>"
end

map('i', '<Space>', smart_space, { expr = true })
map('i', '<BS>', smart_backspace, { expr = true, replace_keycodes = true })
