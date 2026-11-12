return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",

        config = function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {"cpp","vim", "vimdoc", "lua", "java", "javascript", "typescript", "html", "css", "json", "tsx", "markdown", "markdown_inline", "gitignore", "ninja", "rst"},
          sync_install = false,

            auto_install = true,


          highlight = {
            enable = true,
                additional_vim_regex_highlighting = false,
          },
        }
        end,
    }
}
