local trail_group = vim.api.nvim_create_augroup('TrailspaceHelperFixed', { clear = true })

-- Helper to safely locate our custom match ID
local function get_match_id()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == 'CustomTrailspace' then
      return match.id
    end
  end
end

-- Refined Highlight Logic
local function highlight_trailspace()
  -- Target only normal, editable files
  local buftype = vim.bo.buftype
  local is_normal_buf = (buftype == '' or buftype == nil)

  if not is_normal_buf or vim.fn.mode() ~= 'n' then
    pcall(vim.fn.matchdelete, get_match_id())
    return
  end

  -- Apply match if it isn't already active in this window
  if not get_match_id() then
    vim.fn.matchadd('CustomTrailspace', [[\s\+$]])
  end
end

-- Trim Logic (Both spaces and trailing blank lines)
local function trim_trailspace()
  if vim.bo.buftype ~= '' then
    return
  end
  local view = vim.fn.winsaveview()

  -- Trim row spaces
  vim.cmd([[keeppatterns %s/\s\+$//e]])

  -- Trim trailing lines
  local n_lines = vim.api.nvim_buf_line_count(0)
  local last_nonblank = vim.fn.prevnonblank(n_lines)
  if last_nonblank < n_lines then
    vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
  end

  vim.fn.winrestview(view)
end

-- Event Hooks
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'InsertLeave', 'TextChanged' }, {
  group = trail_group,
  callback = highlight_trailspace,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'InsertEnter' }, {
  group = trail_group,
  callback = function()
    pcall(vim.fn.matchdelete, get_match_id())
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = trail_group,
  callback = trim_trailspace,
})

-- Setup the highlight color group explicitly
vim.api.nvim_create_autocmd('ColorScheme', {
  group = trail_group,
  callback = function()
    vim.api.nvim_set_hl(0, 'CustomTrailspace', {
      default = false,
      bg = '#f38ba8',
    })
  end,
})
