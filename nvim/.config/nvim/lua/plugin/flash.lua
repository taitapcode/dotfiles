vim.pack.add({ 'https://github.com/folke/flash.nvim' })

local flash = require('flash')
flash.setup({
  jump = {
    autojump = true,
    nohlsearch = true,
  },
  modes = {
    search = {
      enabled = true,
    },
    char = {
      enabled = false,
    },
  },
})

map({ 'n', 'x', 'o' }, '<M-f>', function()
  flash.jump()
end, { desc = 'Flash jump' })

map({ 'n', 'x', 'o' }, '<M-F>', function()
  flash.treesitter()
end, { desc = 'Flash jump' })
