return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- hier könntest du Standard-Optionen setzen, z.B.:
			plugins = {
				spelling = true,
				marks = true,
				registers = true,
			},
		},
		config = function(_, opts)
			local which_key = require("which-key")
			which_key.setup(opts)

			-- deine Shortcuts/Prefix-Registrierungen
			local mapping = {
				{ "<leader>/", group = "Comments" },
				{ "<leader>/_", hidden = true },

				{ "<leader>J", group = "[J]ava" },
				{ "<leader>J_", hidden = true },

				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },

				{ "<leader>d", group = "[D]ebug" },
				{ "<leader>d_", hidden = true },

				{ "<leader>e", group = "[E]xplorer" },
				{ "<leader>e_", hidden = true },

				{ "<leader>f", group = "[F]ind" },
				{ "<leader>f_", hidden = true },

				{ "<leader>g", group = "[G]it" },
				{ "<leader>g_", hidden = true },

				{ "<leader>w", group = "[W]indow" },
				{ "<leader>w_", hidden = true },
			}
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
