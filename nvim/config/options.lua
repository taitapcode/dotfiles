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

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.mouse = 'a'
vim.cmd('filetype plugin indent on')

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.fillchars = 'eob: '
vim.opt.shortmess:append('WcC')
vim.opt.splitkeep = 'screen'

-- Extra UI adjustments
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.winblend = 10
vim.opt.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣'
vim.opt.list = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.virtualedit = 'block'
vim.opt.formatoptions = 'qjl1'

require('vim._core.ui2').enable()
