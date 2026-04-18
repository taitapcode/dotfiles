vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
})

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
    -- LSP
    'lua_ls',
    'fish_lsp',
    'clangd',
    'basedpyright',
    'bash-language-server',

    -- Formatter
    'stylua',
    'black',
  },
  auto_update = true,
})

vim.lsp.enable({ 'gdscript' })

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
      telemetry = { enable = false },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(args)
    -- Helper to avoid repeating the buffer ID and 'LSP' description
    local function lsp_map(lhs, rhs, desc)
      map('n', lhs, rhs, { buffer = args.buf, desc = 'LSP: ' .. desc })
    end

    -- Navigation & Definitions
    lsp_map('gd', function()
      Snacks.picker.lsp_definitions()
    end, 'Goto Definition')
    lsp_map('gD', function()
      Snacks.picker.lsp_declarations()
    end, 'Goto Declaration')
    lsp_map('gr', function()
      Snacks.picker.lsp_references()
    end, 'References')
    lsp_map('gI', function()
      Snacks.picker.lsp_implementations()
    end, 'Goto Implementation')
    lsp_map('gy', function()
      Snacks.picker.lsp_type_definitions()
    end, 'Type Definition')
    lsp_map('<leader>sd', function()
      Snacks.picker.diagnostics_buffer()
    end, 'Buffer Diagnostics')

    -- Calls & Symbols
    lsp_map('gai', function()
      Snacks.picker.lsp_incoming_calls()
    end, 'Incoming Calls')
    lsp_map('gao', function()
      Snacks.picker.lsp_outgoing_calls()
    end, 'Outgoing Calls')
    lsp_map('<leader>sy', function()
      Snacks.picker.lsp_symbols()
    end, 'Symbols')
    lsp_map('<leader>sS', function()
      Snacks.picker.lsp_workspace_symbols()
    end, 'Workspace Symbols')

    -- Standard LSP Actions
    lsp_map('K', vim.lsp.buf.hover, 'Hover Documentation')
    lsp_map('<leader>cr', vim.lsp.buf.rename, 'Rename Symbol')
    lsp_map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    lsp_map('<leader>cd', vim.diagnostic.open_float, 'Line Diagnostics')
  end,
})
