-- Disable autoformat on cpp
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'cpp' },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

-- Start Godot host if project.godot exists
-- Put this flags in Godot external text editor: --server ./godot --remote-send ':e {file}<CR>{line}G{col}|'
local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart('./godot')
end

-- Highlight yank
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
--   pattern = '*',
--   desc = 'highlight selection on yank',
--   callback = function()
--     vim.highlight.on_yank({ timeout = 200, visual = true })
--   end,
-- })

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, "'")
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd('normal! zz')
      end)
    end
  end,
})

-- Open help in vertical split
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = 'help',
-- 	command = 'wincmd L',
-- })

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- No auto continue comments on new line
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('no_auto_comment', {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

-- Syntax highlighting for dotenv files
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('dotenv_ft', { clear = true }),
  pattern = { '.env', '.env.*' },
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

-- Show cursorline only in active window enable
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('active_cursorline', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- Show cursorline only in active window disable
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  group = 'active_cursorline',
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Disable cursorline on Snake pickers
local cursorline_group = vim.api.nvim_create_augroup('CursorLineControl', { clear = true })
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = cursorline_group,
  callback = function()
    -- List of filetypes where we DON'T want the global cursorline
    local ignore_ft = {
      'snacks_picker_list',
      'snacks_picker_input',
    }

    if vim.tbl_contains(ignore_ft, vim.bo.filetype) then
      vim.opt_local.cursorline = false
    else
      vim.opt_local.cursorline = true
    end
  end,
})

-- Keep the WinLeave one as is
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Fix 'q:' lag and accidental command window opening
vim.api.nvim_create_autocmd('CmdwinEnter', {
  group = vim.api.nvim_create_augroup('NoCommandHistory', { clear = true }),
  callback = function()
    -- 1. Close the accidental command-line window
    vim.cmd('quit')
    -- 2. Open the actual command line with a ':'
    -- We use feedkeys so it happens after the window closes
    vim.api.nvim_feedkeys(':', 'n', false)
  end,
})
