vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = {
    enabled = true,
    b = { completion = false },
  },
  picker = {
    enabled = true,
    -- layout = "ivy",
    sources = {
      files = { hidden = true },
    },
    win = {
      input = {
        keys = {
          ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          ['<C-o>'] = { 'confirm', mode = { 'n', 'i' } },
        },
      },
    },
  },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_picker_input',
  callback = function()
    -- Disable mini.completion for this specific buffer
    vim.b.minicompletion_disable = true

    -- Prevent Neovim 0.12 nightly's native autocomplete from triggering (if enabled)
    vim.opt_local.autocomplete = false
  end,
})

-- Delete Buffer
MAP('n', '<m-w>', function()
  Snacks.bufdelete()
end, { desc = 'Delete Buffer' })

-- Files Picker
MAP('n', '<leader><space>', function()
  Snacks.picker.files({ layout = { preset = 'ivy' } })
end, { desc = 'Find Files' })
MAP('n', '<leader>,', function()
  Snacks.picker.buffers({ layout = { preset = 'ivy' } })
end, { desc = 'Buffers' })
MAP('n', '<leader>/', function()
  Snacks.picker.grep({ layout = { preset = 'ivy' } })
end, { desc = 'Grep' })
MAP('n', '<leader>fc', function()
  Snacks.picker.files({
    cwd = vim.fn.stdpath('config'),
    layout = { preset = 'ivy' },
  })
end, { desc = 'Find Config File' })
MAP('n', '<leader>:', function()
  Snacks.picker.command_history()
end, { desc = 'Command History' })
MAP('n', '<leader>n', function()
  Snacks.picker.notifications()
end, { desc = 'Notification History' })

-- Find
MAP('n', '<leader>fb', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })
MAP('n', '<leader>fg', function()
  Snacks.picker.git_files()
end, { desc = 'Find Git Files' })
MAP('n', '<leader>fp', function()
  Snacks.picker.projects()
end, { desc = 'Projects' })
MAP('n', '<leader>fr', function()
  Snacks.picker.recent({ layout = { preset = 'ivy' } })
end, { desc = 'Recent' })

-- Git
MAP('n', '<leader>gb', function()
  Snacks.picker.git_branches()
end, { desc = 'Git Branches' })
MAP('n', '<leader>gl', function()
  Snacks.picker.git_log()
end, { desc = 'Git Log' })
MAP('n', '<leader>gL', function()
  Snacks.picker.git_log_line()
end, { desc = 'Git Log Line' })
MAP('n', '<leader>gs', function()
  Snacks.picker.git_status()
end, { desc = 'Git Status' })
MAP('n', '<leader>gS', function()
  Snacks.picker.git_stash()
end, { desc = 'Git Stash' })
MAP('n', '<leader>gd', function()
  Snacks.picker.git_diff()
end, { desc = 'Git Diff (Hunks)' })
MAP('n', '<leader>gf', function()
  Snacks.picker.git_log_file()
end, { desc = 'Git Log File' })
MAP('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Open lazygit' })

-- Grep & Search
MAP('n', '<leader>sb', function()
  Snacks.picker.lines()
end, { desc = 'Buffer Lines' })
MAP('n', '<leader>sB', function()
  Snacks.picker.grep_buffers({ layout = { preset = 'ivy' } })
end, { desc = 'Grep Open Buffers' })
MAP('n', '<leader>sg', function()
  Snacks.picker.grep({ layout = { preset = 'ivy' } })
end, { desc = 'Grep' })
MAP({ 'n', 'x' }, '<leader>sw', function()
  Snacks.picker.grep_word({ layout = { preset = 'ivy' } })
end, { desc = 'Visual selection or word' })
MAP('n', '<leader>s"', function()
  Snacks.picker.registers({ layout = { preset = 'ivy' } })
end, { desc = 'Registers' })
MAP('n', '<leader>s/', function()
  Snacks.picker.search_history({ layout = { preset = 'ivy' } })
end, { desc = 'Search History' })
MAP('n', '<leader>sa', function()
  Snacks.picker.autocmds()
end, { desc = 'Autocmds' })
MAP('n', '<leader>sc', function()
  Snacks.picker.command_history()
end, { desc = 'Command History' })
MAP('n', '<leader>sC', function()
  Snacks.picker.commands()
end, { desc = 'Commands' })
MAP('n', '<leader>sh', function()
  Snacks.picker.help({ layout = { preset = 'ivy' } })
end, { desc = 'Help Pages' })
MAP('n', '<leader>si', function()
  Snacks.picker.icons()
end, { desc = 'Icons' })
MAP('n', '<leader>sj', function()
  Snacks.picker.jumps()
end, { desc = 'Jumps' })
MAP('n', '<leader>sk', function()
  Snacks.picker.keymaps({ layout = { preset = 'vscode' } })
end, { desc = 'Keymaps' })
MAP('n', '<leader>sl', function()
  Snacks.picker.loclist()
end, { desc = 'Location List' })
MAP('n', '<leader>sm', function()
  Snacks.picker.marks()
end, { desc = 'Marks' })
MAP('n', '<leader>sM', function()
  Snacks.picker.man()
end, { desc = 'Man Pages' })
MAP('n', '<leader>sq', function()
  Snacks.picker.qflist()
end, { desc = 'Quickfix List' })
MAP('n', '<leader>sR', function()
  Snacks.picker.resume()
end, { desc = 'Resume' })
MAP('n', '<leader>su', function()
  Snacks.picker.undo()
end, { desc = 'Undo History' })
MAP('n', '<leader>ss', function()
  Snacks.picker.lsp_symbols({ layout = { preset = 'right' } })
end, { desc = 'LSP Symbols (Outline)' })
MAP('n', '<leader>sS', function()
  Snacks.picker.lsp_workspace_symbols({ layout = { preset = 'right' } })
end, { desc = 'LSP Workspace Symbols' })
