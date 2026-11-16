return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({})

            -- Gewünschte Parser installieren
            ts.install({
                "cpp", "vim", "vimdoc", "lua", "java",
                "javascript", "typescript", "html", "css",
                "json", "tsx", "markdown", "markdown_inline",
                "gitignore", "ninja", "rst"
            })

            -- Treesitter-Highlighting für alle installierten Sprachen aktivieren
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    }
}
