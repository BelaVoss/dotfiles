return {

	"mfussenegger/nvim-dap",

	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = {
					"java",
				},
			},
		},
		-- ui plugins to make debugging simplier
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
			-- when the debugger is launched open up the debug ui
			dapui.open()
		end

		-- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })

		-- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

		-- set a vim motion for <Space> + d + n to step over
		vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "[D]ebug [N]ext" })

		-- set a vim motion for <Space> + d + i to step into a method
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug [I]nto" })

		-- set a vim motion for <Space> + d + o to step out a method
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[D]ebug [O]ut" })

		-- set a vim motion for <Space> + d + r to Read-Eval-Print Loop e.g. insert i+10 to see the result of i+10
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[D]ebug [R]EPL" })

		-- set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose" })
	end,
}
