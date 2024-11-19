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
    'lualine.nvim',
    opts = function(_, opts)
      table.remove(opts.sections.lualine_x, 1)
    end,
  },
}
