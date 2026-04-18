vim.pack.add({
  'https://github.com/nvim-mini/mini.move',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.basics',
})

require('mini.move').setup()
require('mini.pairs').setup()
require('mini.basics').setup {
  options = {
    basic = true,
    extra_ui = true,
    win_borders = 'double'
  },
  mappings = {
    basic = true,
    windows = true,
    move_with_alt = true,
  },
  autocommands = {
    basic = true,
  }
}
