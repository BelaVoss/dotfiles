return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle [E]xplorer" },
    },
    opts = {
        hijack_netrw = true,
        auto_reload_on_write = true,
    },
}
