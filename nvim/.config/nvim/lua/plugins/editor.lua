return {
  {
    'mini.files',
    keys = {
      {
        '<leader>e',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (Directory of Current File)',
      },
    },
    opts = function(_, opts)
      opts.options.use_as_default_explorer = true
      opts.mappings = {
        go_in = '',
        go_out = '',
        go_in_plus = 'l',
        go_out_plus = 'h',
      }
    end,
  },
  {
    'neo-tree.nvim',
    opts = {
      close_if_last_window = true,
      window = {
        width = 27,
        mappings = {
          ['o'] = 'open',
          ['oc'] = 'none',
          ['od'] = 'none',
          ['og'] = 'none',
          ['om'] = 'none',
          ['on'] = 'none',
          ['os'] = 'none',
          ['ot'] = 'none',
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          -- hide_by_name = {
          --   "node_modules",
          -- },
          never_show = {
            '.git',
            'node_modules',
          },
        },
      },
    },
  },
  {
    'flash.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, false },
      { 'S', mode = { 'n', 'x', 'o' }, false },
      {
        'f',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'F',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
    opts = function(_, opts)
      opts.jump = {
        autojump = true,
        nohlsearch = true,
      }

      opts.modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      }
    end,
  },
}
