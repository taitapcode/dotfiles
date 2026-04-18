vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

require('lualine').setup({
  sections = {
    lualine_x = { 'filetype' },
  },
})
