vim.pack.add({ 'https://github.com/m4xshen/autoclose.nvim' })

require('autoclose').setup({
  options = {
    disable_command_mode = true,
    disable_when_touch = true,
    pair_spaces = true,
  },
})
