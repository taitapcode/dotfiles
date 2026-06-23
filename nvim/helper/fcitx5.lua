if vim.fn.executable('fcitx5-remote') ~= 1 then
  return
end

local default_layout = 'keyboard-us'
local last_layout = default_layout

local function get_current_layout()
  local output = vim.fn.system({ 'fcitx5-remote', '-n' })
  if vim.v.shell_error ~= 0 then
    return default_layout
  end

  local layout = output:gsub('%s+', '')
  if layout == '' then
    return default_layout
  end
  return layout
end

local function set_layout(layout)
  if layout then
    vim.fn.system({ 'fcitx5-remote', '-s', layout })
  end
end

local fcitx_group = vim.api.nvim_create_augroup('FcitxSwitch', { clear = true })

-- When leaving Insert mode: Save the exact current layout and switch back to default layout
vim.api.nvim_create_autocmd('InsertLeave', {
  group = fcitx_group,
  callback = function()
    local current = get_current_layout()
    last_layout = current -- Always remember the last layout

    if current ~= default_layout then
      set_layout(default_layout)
    end
  end,
})

-- When entering Insert mode: Restore the layout used in the previous insert session
vim.api.nvim_create_autocmd('InsertEnter', {
  group = fcitx_group,
  callback = function()
    if last_layout ~= default_layout then
      set_layout(last_layout)
    end
  end,
})
