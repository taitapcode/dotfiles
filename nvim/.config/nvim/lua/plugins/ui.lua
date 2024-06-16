return {
  {
    'bufferline.nvim',
    opts = {
      options = {
        -- always_show_bufferline = true,
        separator_style = 'slant',
        diagnostics_update_in_insert = true,
      },
    },
  },

  {
    'noice.nvim',
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    'dashboard-nvim',
    opts = function(_, opts)
      opts.config.center = {
        {
          action = LazyVim.pick('files'),
          desc = ' Find File',
          icon = ' ',
          key = 'f',
        },
        {
          action = 'ene | startinsert',
          desc = ' New File',
          icon = ' ',
          key = 'n',
        },
        {
          action = 'Telescope oldfiles',
          desc = ' Recent Files',
          icon = ' ',
          key = 'r',
        },
        {
          action = 'Telescope live_grep',
          desc = ' Find Text',
          icon = ' ',
          key = 'g',
        },
        {
          action = 'qa',
          desc = ' Quit',
          icon = ' ',
          key = 'q',
        },
      }

      opts.config.footer = { '💤  Best neovim for a lazy guy 󰒲' }
    end,
  },

  {
    'lualine.nvim',
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 1)
    end,
  },
}
