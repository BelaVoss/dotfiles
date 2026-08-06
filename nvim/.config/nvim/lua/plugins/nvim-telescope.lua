return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			-- general purpose plugin used to build user interfaces in neovim plugins
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[F]ind [F]iles",
				mode = "n",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[F]ind by [G]rep",
				mode = "n",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[F]ind [D]iagnostics",
				mode = "n",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "[F]inder [R]esume",
				mode = "n",
			},
			{
				"<leader>f.",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "[F]ind Recent Files ('.' for repeat)",
				mode = "n",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "[F]ind Existing [B]uffers",
				mode = "n",
			},
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local actions = require("telescope.actions")

			telescope.setup({
				extensions = {
					["ui-select"] = themes.get_dropdown({}),
				},
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
						},
					},
				},
			})

			telescope.load_extension("ui-select")
		end,
	},
}
