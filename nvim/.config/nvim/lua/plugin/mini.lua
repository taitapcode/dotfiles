vim.pack.add({
  'https://github.com/nvim-mini/mini.move',
  'https://github.com/nvim-mini/mini.basics',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.surround'
})

require('mini.move').setup()
require('mini.ai').setup()
require('mini.surround').setup()

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
