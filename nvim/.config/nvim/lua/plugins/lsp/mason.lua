return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"jdtls",
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"pyright",
				"clangd",
			},
			automatic_enable = {
				exclude = {
					--needs external plugin
					"jdtls",
				},
			},
		},

		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			{ "mfussenegger/nvim-jdtls" },
			{ "neovim/nvim-lspconfig" },
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"java-debug-adapter",
				"java-test",
				"ruff",
				"stylua",
				"clang-format",
                "codelldb",
			},
		},
	},
}
