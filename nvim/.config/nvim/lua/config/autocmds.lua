-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat on cpp
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'cpp' },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })

-- Auto remove trailing whitespace on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})

-- Start Godot host if project.godot exists
local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart('./godothost')
end
