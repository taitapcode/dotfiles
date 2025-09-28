return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
      { 'Saghen/blink.compat', version = '*', lazy = true, opts = {} },
      'hrsh7th/cmp-calc',
    },
    opts = function(_, opts)
      table.insert(opts.sources.default, 'avante')
      opts.sources.providers.avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {},
      }

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
}
