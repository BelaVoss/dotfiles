return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			-- feed luasnip suggestions to cmp
			"saadparwaiz1/cmp_luasnip",
			-- provide vscode like snippets to cmp
			"rafamadriz/friendly-snippets",
		},
	},
	-- cmp-nvim-lsp provides language specific completion suggestions to nvim-cmp
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	-- nvim-cmp provides auto completion and auto completion dropdown ui
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- buffer based completion options
			"hrsh7th/cmp-buffer",
			-- path based completion options
			"hrsh7th/cmp-path",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Lazily load the vscode like snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- How should completion options be displayed to us?
			opts.completion = {
				completeopt = "menu,menuone,preview,noselect",
			}

			-- setup snippet support based on the active lsp and the current text of the file
			opts.snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			}

			-- setup how we interact with completion menus and options
			opts.mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			})

			-- Where and how should cmp rank and find completions
			opts.sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			})

			-- C++ spezifische Sortierung über clangd_extensions einbinden
			opts.sorting = opts.sorting or {}
			opts.sorting.comparators = opts.sorting.comparators or {}
			table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
		end,
	},
}
