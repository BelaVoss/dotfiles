return {
	"mfussenegger/nvim-dap",

	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = {
					"java",
					"codelldb",
				},
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
					codelldb = function(config)
						config.configurations = {
							{
								type = "codelldb",
								request = "launch",
								name = "Launch file",
								program = function()
									return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
								end,
								cwd = "${workspaceFolder}",
							},
							{
								type = "codelldb",
								request = "attach",
								name = "Attach to process",
								pid = require("dap.utils").pick_process,
								cwd = "${workspaceFolder}",
							},
						}
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			},
		},
		-- ui plugins to make debugging simpler
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup the dap ui with default configuration
		dapui.setup()

		-- setup an event listener for when the debugger is launched
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		-- Keymaps
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "[D]ebug [N]ext" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug [I]nto" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[D]ebug [O]ut" })
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]ebug [R]EPL" })
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })
	end,
}
