-- If the fcitx5-remote binary doesn't exist, stop right here.
if vim.fn.executable('fcitx5-remote') ~= 1 then
  return
end

local default_layout = 'keyboard-us'
local last_layout = default_layout

local function get_current_layout()
  -- popen can fail if the process isn't running or accessible
  local f = io.popen('fcitx5-remote -n 2>/dev/null')
  if f == nil then
    return default_layout
  end

  local layout = f:read('*all'):gsub('%s+', '')
  f:close()

  -- If fcitx5 is installed but the daemon isn't running,
  -- the output will be empty.
  if layout == '' then
    return default_layout
  end

  return layout
end

local function set_layout(layout)
  if layout then
    -- Redirect stderr to /dev/null to keep the UI clean if it fails
    os.execute('fcitx5-remote -s ' .. layout .. ' >/dev/null 2>&1')
  end
end

local fcitx_group = vim.api.nvim_create_augroup('FcitxSwitch', { clear = true })

-- When leaving insert mode: save layout and switch to English
vim.api.nvim_create_autocmd('InsertLeave', {
  group = fcitx_group,
  callback = function()
    local current = get_current_layout()
    -- Only update last_layout if we actually got a valid layout back
    if current ~= default_layout or last_layout == default_layout then
      last_layout = current
    end
    set_layout(default_layout)
  end,
})

-- When entering insert mode: restore the last used layout
vim.api.nvim_create_autocmd('InsertEnter', {
  group = fcitx_group,
  callback = function()
    -- Only bother calling fcitx if we have a non-default layout to restore
    if last_layout ~= default_layout then
      set_layout(last_layout)
    end
  end,
})
