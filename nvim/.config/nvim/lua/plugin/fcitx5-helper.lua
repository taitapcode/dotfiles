local default_layout = 'keyboard-us'
local last_layout = default_layout

local function get_current_layout()
  local f = io.popen('fcitx5-remote -n')
  local layout = default_layout
  if f ~= nil then
    layout = f:read('*all'):gsub('%s+', '')
    f:close()
  end
  return layout
end

local function set_layout(layout)
  if layout then
    os.execute('fcitx5-remote -s ' .. layout)
  end
end

local fcitx_group = vim.api.nvim_create_augroup('FcitxSwitch', { clear = true })

-- When leaving insert mode: save layout and switch to English
vim.api.nvim_create_autocmd('InsertLeave', {
  group = fcitx_group,
  callback = function()
    local current = get_current_layout()
    last_layout = current
    set_layout(default_layout)
  end,
})

-- When entering insert mode: restore the last used layout
vim.api.nvim_create_autocmd('InsertEnter', {
  group = fcitx_group,
  callback = function()
    set_layout(last_layout)
  end,
})
