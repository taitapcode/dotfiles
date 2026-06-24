vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1

MAP("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux: Move Left" })
MAP("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux: Move Down" })
MAP("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux: Move Up" })
MAP("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux: Move Right" })
MAP("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux: Move Previous" })
