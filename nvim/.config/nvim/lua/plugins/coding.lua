return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
    },
    opts = function(_, opts)
      table.insert(opts.sources.default, 'avante')
      opts.sources.providers.avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {
          -- options for blink-cmp-avante
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
