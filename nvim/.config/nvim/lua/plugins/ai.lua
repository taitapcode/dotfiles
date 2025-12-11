return {
  { 'zbirenbaum/copilot.lua' },
  {
    'yetone/avante.nvim',
    opts = function(_, opts)
      opts.provider = 'copilot'
      opts.providers = {
        gemini = {
          model = 'gemini-2.0-flash',
          timeout = 30000,
          extra_request_body = {
            max_tokens = 16384,
          },
        },
        copilot = {
          model = 'claude-haiku-4.5',
          timeout = 30000,
        },
      }
      opts.web_search_engine = {
        provider = 'tavily',
      }
      opts.behaviour = {
        support_paste_from_clipboard = true,
        auto_add_current_file = false,
      }
      opts.windows = {
        width = 35,
        sidebar_header = {
          enabled = true,
          align = 'center',
          rounded = true,
        },
        ask = {
          border = 'rounded',
          start_insert = false,
        },
      }
      opts.input = {
        provider = 'snacks',
        provider_opts = {
          title = 'Avante Input',
          icon = ' ',
        },
      }
      opts.mappings = {
        submit = {
          insert = '<C-e>',
        },
      }
      opts.disabled_tools = { 'fetch' }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        copilot = {
          keys = {
            {
              '<M-CR>',
              function()
                vim.lsp.inline_completion.get()
              end,
              desc = 'Accept Copilot Suggestion',
              mode = { 'i', 'n' },
            },
          },
        },
      },
    },
  },
  {
    'sidekick.nvim',
    keys = {
      { '<leader>aa', false },
    },
  },
}
