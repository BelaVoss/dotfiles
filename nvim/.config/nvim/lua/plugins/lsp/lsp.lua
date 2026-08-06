return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		local keymap = vim.keymap -- for conciseness
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds

				-- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
				opts.desc = "[C]ode [H]over Documentation"
				keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts)

				-- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
				opts.desc = "[C]ode Goto [D]efinition"
				keymap.set("n", "<leader>cd", vim.lsp.buf.definition, opts)

				-- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
				opts.desc = "[C]ode [A]ctions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				-- Set vim motion for <Space> + c + r to display references to the code under the cursor
				opts.desc = "[C]ode Goto [R]eferences"
				keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, opts)

				-- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
				opts.desc = "[C]ode Goto [I]mplementations"
				keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, opts)

				-- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
				opts.desc = "[C]ode [R]ename"
				keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts)

				-- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
				opts.desc = "[C]ode Goto [D]eclaration"
				keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts)
			end,
		})

		-- vim.lsp.inlay_hint.enable(true)
		local severity = vim.diagnostic.severity

		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = " ",
					[severity.WARN] = " ",
					[severity.HINT] = "󰠠 ",
					[severity.INFO] = " ",
				},
			},
		})
	end,
}
