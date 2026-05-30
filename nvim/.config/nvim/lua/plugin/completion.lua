vim.pack.add({
  'https://github.com/saghen/blink.cmp',
  'https://github.com/saghen/blink.lib',
  'https://github.com/fang2hou/blink-copilot',
  'https://github.com/rafamadriz/friendly-snippets',
})

local cmp = require('blink.cmp')
cmp.build():pwait()

cmp.setup({
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        async = true,
      },
    },
  },
  completion = {
    documentation = { auto_show = true },
  },
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
  },
})
