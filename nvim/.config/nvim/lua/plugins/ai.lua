return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      provider = 'copilot',
      providers = {
        gemini = {
          model = 'gemini-2.0-flash', -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          extra_request_body = {
            max_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
          },
        },
        copilot = {
          model = 'claude-sonnet-4',
          timeout = 30000,
        },
      },
      -- selector = {
      --   provider = 'snacks',
      -- },
      web_search_engine = {
        provider = 'tavily', -- Required TAVILY_API_KEY environment variable
      },
      behaviour = {
        support_paste_from_clipboard = true,
        auto_add_current_file = false,
      },
      windows = {
        width = 35,
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = 'center', -- left, center, right for title
          rounded = true,
        },
        ask = {
          border = 'rounded',
          start_insert = false, -- Start insert mode when opening the edit window
        },
      },
      input = {
        provider = 'snacks',
        provider_opts = {
          -- Additional snacks.input options
          title = 'Avante Input',
          icon = ' ',
        },
      },
      mappings = {
        submit = {
          insert = '<C-e>', -- submit the current query
        },
      },
      disabled_tools = { 'fetch' },
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        return hub and 'Today is ' .. os.date('%d/%m/%Y') .. '.' .. hub:get_active_servers_prompt() or ''
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'bundled_build.lua', -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
      require('mcphub').setup({
        use_bundled_binary = true, -- Use local `mcp-hub` binary
      })
    end,
  },
}
