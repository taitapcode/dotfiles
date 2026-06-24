local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.enable({
	"nixd",
	"lua_ls",
	"fish_lsp",
	"clangd",
	"basedpyright",
	"bashls",
	"gdscript",
	"copilot",
})

vim.lsp.config("nixd", {
	settings = {
		nixd = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("copilot", {
	cmd = { "copilot-language-server", "--stdio" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(args)
		-- Helper to avoid repeating the buffer ID and 'LSP' description
		local function lsp_map(lhs, rhs, desc)
			MAP("n", lhs, rhs, { buffer = args.buf, desc = "LSP: " .. desc })
		end

		-- Navigation & Definitions
		lsp_map("gd", function()
			Snacks.picker.lsp_definitions()
		end, "Goto Definition")
		lsp_map("gD", function()
			Snacks.picker.lsp_declarations()
		end, "Goto Declaration")
		lsp_map("gr", function()
			Snacks.picker.lsp_references()
		end, "References")
		lsp_map("gI", function()
			Snacks.picker.lsp_implementations()
		end, "Goto Implementation")
		lsp_map("gy", function()
			Snacks.picker.lsp_type_definitions()
		end, "Type Definition")
		lsp_map("<leader>sd", function()
			Snacks.picker.diagnostics()
		end, "Diagnostics")
		lsp_map("<leader>sD", function()
			Snacks.picker.diagnostics_buffer()
		end, "Buffer Diagnostics")

		-- Calls & Symbols
		lsp_map("gai", function()
			Snacks.picker.lsp_incoming_calls()
		end, "Incoming Calls")
		lsp_map("gao", function()
			Snacks.picker.lsp_outgoing_calls()
		end, "Outgoing Calls")
		lsp_map("<leader>sy", function()
			Snacks.picker.lsp_symbols()
		end, "Symbols")
		lsp_map("<leader>sS", function()
			Snacks.picker.lsp_workspace_symbols()
		end, "Workspace Symbols")

		-- Standard LSP Actions
		lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
		lsp_map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		lsp_map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
	end,
})

vim.diagnostic.config({
	-- virtual_text = {
	--   spacing = 4,
	--   prefix = '●', -- Or any icon like '󰅚'
	--   severity = { min = vim.diagnostic.severity.WARN },
	-- },

	virtual_lines = { current_line = true },
	underline = true,
	signs = true,
	update_in_insert = true, -- Set to true if you want live feedback as you type
	severity_sort = true,
})
