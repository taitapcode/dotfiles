return {
  {
    'telescope.nvim',
    opts = function(_, opts)
      opts.defaults.prompt_prefix = ' '
      opts.defaults.selection_caret = '󰋇 '
      opts.defaults.theme = 'center'
      opts.defaults.file_ignore_patterns = { 'node_modules', '.git' }
      opts.defaults.layout_config = {
        horizontal = {
          prompt_position = 'bottom',
          preview_width = 0.4,
        },
      }

      local telescope_actions = require('telescope.actions')
      opts.defaults.mappings.i = {
        ['<esc>'] = telescope_actions.close,
        ['<C-k>'] = telescope_actions.move_selection_previous,
        ['<C-j>'] = telescope_actions.move_selection_next,
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
}
