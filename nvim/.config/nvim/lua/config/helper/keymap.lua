-- Shared state to prevent infinite loops when a combo feeds keys back into Neovim
local combo_ignore = false
local unignore_later = vim.schedule_wrap(function()
  combo_ignore = false
end)

-- Handle breaking changes in the `vim.on_key` API signature between Neovim versions
-- Neovim 0.11+ passes (key, typed), while older versions just pass (key)
local get_key = vim.fn.has('nvim-0.11') == 1 and function(_, typed)
  return typed
end or function(key)
  return key
end

--- Tokenizes a key string into an array of individual keys
--- Handles complex chords safely (e.g., converts "<Esc><Esc>" to { "<Esc>", "<Esc>" })
---@param lhs string|table The key sequence to parse
---@return table An array of discrete key characters/chords
local function lhs_to_seq(lhs)
  if type(lhs) == 'table' then
    return vim.deepcopy(lhs)
  end
  local res, i = {}, 1
  while i <= lhs:len() do
    local k, new_i = string.match(lhs, '^(%b<>)()', i)
    -- Fallback for single characters or incomplete tags
    if k == nil or k:find('^.+<') ~= nil then
      k, new_i = vim.fn.strcharpart(lhs, i - 1, 1), i + 1
    end
    table.insert(res, k)
    i = new_i
  end
  return res
end

--- Normalizes user mode inputs into an internal dictionary map for fast O(1) lookups
--- Expands broad groups like 'x' (Visual) and 'v' (Visual + Select) into actual Vim mode characters
---@param modes string|table Target mode(s)
---@return table A lookup table where modes are keys set to true
local function make_mode_tbl(modes)
  local res = {}
  local mode_list = type(modes) == 'string' and { modes } or modes
  for _, m in ipairs(mode_list) do
    if m == 'x' then
      res.v, res.V, res['\22'] = true, true, true -- Visual, Visual-Line, Visual-Block
    elseif m == 'v' then
      res.s, res.v, res.V, res['\22'] = true, true, true, true -- Visual paths + Select mode
    else
      res[m] = true
    end
  end
  return res
end

-- Unique counter to prevent internal namespace collisions across multiple combos
local combo_counter = 0

--- Creates a rapid key combination shortcut (Combo) using low-level key listeners
--- Each key triggers instantly, but if the full sequence completes within the delay window,
--- the specified action executes.
---@param modes string|table Vim mode or array of modes (e.g., { 'n', 'i', 'c' })
---@param lhs string The sequence to watch for (e.g., '<Esc><Esc>' or 'jk')
---@param action string|function Executed when sequence hits. Strings are run as input keys
---@param opts table|nil Custom parameters. Supports `delay` in milliseconds (default: 200)
MAP_COMBO = function(modes, lhs, action, opts)
  modes = type(modes) == 'string' and { modes } or modes
  local mode_tbl = make_mode_tbl(modes)

  -- Parse inputs and resolve internal terminal keycodes (e.g., translating '<Esc>')
  local seq = lhs_to_seq(lhs)
  seq = vim.tbl_map(function(x)
    return vim.api.nvim_replace_termcodes(x, true, true, true)
  end, seq)

  opts = opts or {}
  local delay = opts.delay or 200
  local delay_ns = delay * 1000000 -- Converted to nanoseconds for precision matching

  local hrtime = vim.uv.hrtime
  local i, last_time, n_seq = 0, hrtime(), #seq
  local get_mode = vim.fn.mode

  -- Feeds virtual keys back into Neovim safely without re-triggering this engine
  local input_keys = vim.schedule_wrap(function(keys)
    combo_ignore = true
    vim.api.nvim_input(keys)
    unignore_later()
  end)

  -- Wrap raw text string actions to execute via the input loop
  if type(action) == 'string' then
    local keys = action
    action = function()
      input_keys(keys)
    end
  end

  -- Ensures functions run safely on the main event loop to avoid Neovim lockups
  local act = vim.schedule_wrap(function()
    local keys = action()
    if type(keys) == 'string' and keys ~= '' then
      input_keys(keys)
    end
  end)

  -- Resets tracking state whenever a bad stroke or timeout occurs
  local reset = function(key)
    i = seq[1] == key and 1 or 0
    last_time = i == 0 and last_time or hrtime()
  end

  -- Core listener callback executed on every raw keystroke
  local watcher = function(key, typed)
    key = get_key(key, typed)

    -- Fast exit if key is empty, system is ignoring inputs, or if we are out of bounds/wrong mode
    if key == '' or (i == 0 and not mode_tbl[get_mode()]) or combo_ignore then
      return
    end

    -- Match sequence position
    i = i + 1
    if seq[i] ~= key then
      return reset(key)
    end

    -- Check if keys were typed fast enough
    local cur_time = hrtime()
    if (cur_time - last_time) > delay_ns and i > 1 then
      return reset(key)
    end
    last_time = cur_time

    -- Wait for remaining keys if sequence isn't fully exhausted yet
    if i < n_seq then
      return
    end

    -- Sequence successfully completed! Reset index and fire the action
    i = 0
    act()
  end

  -- Register a clean, uniquely named namespace for tracking this combo's hook
  combo_counter = combo_counter + 1
  local combo_keys = table.concat(vim.tbl_map(vim.fn.keytrans, seq), '')
  local ns_name = string.format('native-combo-%d-%s-%s', combo_counter, table.concat(modes, ''), combo_keys)
  local ns_id = vim.api.nvim_create_namespace(ns_name)

  return vim.on_key(watcher, ns_id)
end

--- Standard global mapping utility wrapping `vim.keymap.set`
--- Enforces smart modern defaults (`noremap = true`, `silent = true`) unless overridden
---@param mode string|table Mode shortcode(s) (e.g., 'n', 'i', { 'n', 'v' })
---@param keybind string The key sequence triggering the mapping
---@param command string|function The command or callback function to execute
---@param opts table|nil Custom layout options to override defaults
MAP = function(mode, keybind, command, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, keybind, command, options)
end
