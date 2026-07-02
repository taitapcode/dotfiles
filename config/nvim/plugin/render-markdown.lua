require('render-markdown').setup({
  checkbox = {
    custom = {
      important = { raw = '[!]', rendered = ' ', highlight = 'DiagnosticWarn' },
      star = { raw = '[*]', rendered = '󰓎 ', highlight = 'RenderMarkdownInfo' },
    },
  },
})

local function toggle_box(target_char)
  local line = vim.api.nvim_get_current_line()
  local current_char = line:match('%[(.)%]')

  if not current_char or not current_char:match('[ %-x!%*]') then
    return
  end

  local next_char = (current_char == target_char) and ' ' or target_char
  local escaped_current = current_char:match('[%-%*]') and '%' .. current_char or current_char
  local pattern = '%[' .. escaped_current .. '%]'
  local new_line = line:gsub(pattern, '[' .. next_char .. ']', 1)

  vim.api.nvim_set_current_line(new_line)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    MAP('n', '\\x', function()
      toggle_box('x')
    end, { buffer = true, desc = 'Toggle Checkbox [x]' })

    MAP('n', '\\-', function()
      toggle_box('-')
    end, { buffer = true, desc = 'Toggle In-Progress [-]' })

    MAP('n', '\\!', function()
      toggle_box('!')
    end, { buffer = true, desc = 'Toggle Important [!]' })

    MAP('n', '\\*', function()
      toggle_box('*')
    end, { buffer = true, desc = 'Toggle Star [*]' })
  end,
})
