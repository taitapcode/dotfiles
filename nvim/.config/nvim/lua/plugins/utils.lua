return {
  {
    'LazyVim',
    opts = {
      colorscheme = 'catppuccin-mocha',
    },
  },
  { 'mg979/vim-visual-multi' },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  -- {
  --   'pysan3/fcitx5.nvim',
  --   opts = function(_, opts)
  --     local en = 'keyboard-us'
  --     -- local vi = 'unikey'
  --     opts.imname = {
  --       norm = en,
  --     }
  --   end,
  -- },
  {
    'Wansmer/treesj',
    keys = { '<Leader>m', '<Leader>j', '<Leader>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  },
}
