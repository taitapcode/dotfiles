return {
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'Saghen/blink.compat', version = '*', lazy = true, opts = {} },
      'hrsh7th/cmp-calc',
    },
    opts = function(_, opts)
      table.insert(opts.sources.default, 'calc')
      opts.sources.providers.calc = {
        module = 'blink.compat.source',
        name = 'calc',
        score_offset = -1,
        opts = {
          -- You can add options here if needed
        },
      }

      opts.keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      }
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    ---@param opts cmp.ConfigSchema
    dependencies = { 'hrsh7th/cmp-calc' },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local cmp = require('cmp')

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = 'calc' },
      }))
    end,
  },
}
