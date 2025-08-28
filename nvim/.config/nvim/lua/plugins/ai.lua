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
      },
      web_search_engine = {
        provider = 'google', -- Require set GOOGLE_SEARCH_API_KEY and GOOGLE_SEARCH_ENGINE_ID env variable
      },
      behaviour = {
        support_paste_from_clipboard = true,
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
      mappings = {
        submit = {
          insert = '<C-e>', -- submit the current query
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
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
}
