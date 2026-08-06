return {
    -- Shortened Github Url
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Make sure to set the color scheme when neovim loads and configures the dracula plugin
        vim.cmd.colorscheme "dracula"

        -- Make Neovim transparent
        local groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "SignColumn",
            "LineNr",
            "CursorLineNr",
            "EndOfBuffer",
            "StatusLine",
            "StatusLineNC",
        }

        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
    end
}
