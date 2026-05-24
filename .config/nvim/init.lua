-- Figure out what OS this is on 
local system_lookup = {Windows_NT = "windows", Linux = "linux"}
SYSNAME = system_lookup[vim.loop.os_uname().sysname] -- turn returned values into either "windows" or "linux" for convenience

-- Add classic Vim configurations
local rtps = {linux = "~/.vim", windows = "~/vimfiles"} -- Vim runtimepath lookup
vim.opt.runtimepath:append(rtps[SYSNAME]) -- add vim RTP
vim.cmd("source ~/.vimrc") -- add vimrc

-- Helper
local open_stdfile = function(stp, file)
    return function() vim.cmd.edit(vim.fn.resolve(vim.fn.stdpath(stp) .. file)) end
end
vim.api.nvim_create_user_command("InitLuaEdit", open_stdfile("config", "/init.lua"), {nargs = 0})
vim.api.nvim_create_user_command("SwpDirOpen", open_stdfile("state", "/swap"), {nargs = 0})

-- Packages
local github = "https://github.com/";
vim.pack.add({
	{src = github .. "nvim-mini/mini.nvim", version = "4465783"}, -- Basic QoL
	{src = github .. "mason-org/mason.nvim", version = "bb639d4"}, -- LSP installers
	{src = github .. "neovim/nvim-lspconfig", version = "a4ed4e7"}, -- Default LSP configurations
	{src = github .. "mason-org/mason-lspconfig.nvim", version = "7b01e29"}, -- Automatic install/enable
	{src = github .. "folke/lazydev.nvim", version = "ff2cbcb"}
})

-- QoL
require("mini.surround").setup()
require("mini.pairs").setup()

-- LSP end-to-end
require("mason").setup();
require("mason-lspconfig").setup({
	ensure_installed = {"lua_ls", "clangd", "texlab", "ty", "neocmake"},
	automatic_enable = {
		exclude = {"clangd"} -- for now
	}
})

require("lazydev").setup();
-- 	local snipdir = vim.fn.resolve(vim.fn.stdpath("config") .. "/LuaSnip")
-- 	require("luasnip.loaders.from_lua").load({paths = snipdir})
-- vim.api.nvim_create_user_command("LuaSnipReload", cf_luasnip, {nargs = 0})
