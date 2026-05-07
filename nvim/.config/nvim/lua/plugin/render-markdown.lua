vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })
require('render-markdown').setup({
  checkbox = {
    custom = {
      important = { raw = '[!]', rendered = ' ', highlight = 'DiagnosticWarn' },
      star = { raw = '[*]', rendered = '󰓎 ', highlight = 'RenderMarkdownInfo' },
    },
  },
})
