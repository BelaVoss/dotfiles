-- ~/.config/nvim/init.lua

-- Load the options from the config/options.lua file
require("config.options")

-- Load the keymaps from the config/keymaps.lua file
require("config.keymaps")

-- Load the lazy.lua file
require("config.lazy")

vim.lsp.enable("jdtls")
