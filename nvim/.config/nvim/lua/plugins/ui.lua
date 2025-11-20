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
      opts.presets.lsp_doc_border = true
      table.insert(opts.routes, {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      })

      -- Remove noisy and annoying jdtls notifications
      table.insert(opts.routes, {
        filter = {
          event = 'lsp',
          kind = 'progress',
          find = 'jdtls',
        },
        opts = { skip = true },
      })
    end,
  },
}
