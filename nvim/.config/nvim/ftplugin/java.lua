local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data")
	.. package.config:sub(1, 1)
	.. "jdtls-workspace"
	.. package.config:sub(1, 1)
	.. project_name
	.. "-workspace"

local os_name = vim.loop.os_uname().sysname

-- Tell our JDTLS language features it is capable of
local capabilities = {
	workspace = {
		configuration = true,
	},
	textDocument = {
		completion = {
			snippetSupport = false,
		},
	},
}

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

for k, v in pairs(lsp_capabilities) do
	lsp_capabilities[k] = v
end

-- Get the default extended client capablities of the JDTLS language server
local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- Modify one property called resolveAdditionalTextEditsSupport and set it to true
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}

local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/"

local java_debug_bundle = vim.fn.glob(java_debug_path .. "com.microsoft.java.debug.plugin-*.jar", 1)

if java_debug_bundle ~= "" then
	table.insert(bundles, java_debug_bundle)
end

local launcher =
	vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

-- See `:help vim.lsp.start` for an overview of the supported `config` options.
local config = {
	name = "jdtls",

	-- `cmd` defines the executable to launch eclipse.jdt.ls.
	-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
	--
	-- As alternative you could also avoid the `jdtls` wrapper and launch
	-- eclipse.jdt.ls via the `java` executable
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		launcher,

		"-configuration",
		vim.fn.stdpath("data")
			.. package.config:sub(1, 1)
			.. "mason"
			.. package.config:sub(1, 1)
			.. "packages"
			.. package.config:sub(1, 1)
			.. "jdtls"
			.. package.config:sub(1, 1)
			.. "config_"
			.. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac"),

		"jdtls",
		"-data",
		workspace_dir,
	},

	-- `root_dir` must point to the root of your project.
	-- See `:help vim.fs.root`
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "settings.gradle.kts" }),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- This sets the `initializationOptions` sent to the language server
	-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
	-- you'll need to set the `bundles`
	--
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}

jdtls.start_or_attach(config)

jdtls.setup_dap({
	hotcodereplace = "auto",
})

