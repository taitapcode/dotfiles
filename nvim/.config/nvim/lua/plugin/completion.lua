vim.pack.add({
  'https://github.com/saghen/blink.cmp',
  'https://github.com/saghen/blink.lib',
  'https://github.com/rafamadriz/friendly-snippets',
})

local cmp = require('blink.cmp')
cmp.build():wait(60000)

cmp.setup({
  completion = {
    documentation = { auto_show = true },
  },
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },
})

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
