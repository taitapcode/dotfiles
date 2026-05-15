vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' -- Sync with system clipboard
vim.o.relativenumber = true
vim.o.number = true
vim.o.smartindent = true -- Insert indents automatically
vim.o.tabstop = 2
vim.o.shiftround = true -- Round indent
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.confirm = true
vim.o.completeopt = 'menuone,noinsert'
vim.o.swapfile = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldenable = false

require('vim._core.ui2').enable()

vim.diagnostic.config({
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = '●', -- Or any icon like '󰅚'
  --   severity = { min = vim.diagnostic.severity.WARN },
  -- },

  virtual_lines = { current_line = true },
  underline = true,
  signs = true,
  update_in_insert = true, -- Set to true if you want live feedback as you type
  severity_sort = true,
})
