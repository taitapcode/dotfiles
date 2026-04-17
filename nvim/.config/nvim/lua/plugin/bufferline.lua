vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })

require("bufferline").setup({
  options = {
    show_buffer_icons = true,
    show_close_icon = true,
    show_buffer_close_icons = true,

    close_command = function(n) Snacks.bufdelete(n) end,
    right_mouse_command = function(n) Snacks.bufdelete(n) end,

    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    separator_style = "slant",

    diagnostics_indicator = function(_, _, diag)
      local icons = {
        Error = require('mini.icons').get('lsp', 'error') .. " ",
        Warn  = require('mini.icons').get('lsp', 'warn') .. " ",
      }
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
               .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,

    offsets = {
      {
        filetype = "minifiles",
        text = "Mini Files",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "snacks_layout_box",
      },
    },
  },
})

map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
map("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })

-- Fixes bufferline UI when restoring a session or handling bulk buffer changes
vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      pcall(function()
        if vim.api.nvim_get_vvar("exiting") == vim.NIL then
          require("bufferline").refresh()
        end
      end)
    end)
  end,
})
