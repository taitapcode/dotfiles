vim.pack.add({ 'https://github.com/nvim-mini/mini.icons' })

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
later(MiniIcons.tweak_lsp_kind)
