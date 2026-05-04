vim.pack.add({
  'https://github.com/saghen/blink.cmp',
  'https://github.com/saghen/blink.lib',
  'https://github.com/rafamadriz/friendly-snippets',
})

local cmp = require('blink.cmp')
cmp.build():wait(60000)

cmp.setup({
  completion = { documentation = { auto_show = true } },
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },
})
