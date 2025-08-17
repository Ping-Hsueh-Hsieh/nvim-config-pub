-- 📂lua/📂themes/🌑doom-one.lua

local status, _ = pcall(require, "doom-one")
if not status then
    return
end

-- Add color to cursor
vim.g.doom_one_cursor_coloring = true
-- Set :terminal colors
vim.g.doom_one_terminal_colors = true
-- Enable italic comments
vim.g.doom_one_italic_comments = false
-- Enable TS support
vim.g.doom_one_enable_treesitter = true
-- Color whole diagnostic text or only underline
vim.g.doom_one_diagnostics_text_color = false
-- Enable transparent background
vim.g.doom_one_transparent_background = false

-- Pumblend transparency
vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20

-- Plugins integration
vim.g.doom_one_plugin_neorg = true
vim.g.doom_one_plugin_barbar = true
vim.g.doom_one_plugin_telescope = true
vim.g.doom_one_plugin_neogit = true
vim.g.doom_one_plugin_nvim_tree = true
vim.g.doom_one_plugin_dashboard = true
vim.g.doom_one_plugin_startify = true
vim.g.doom_one_plugin_whichkey = true
vim.g.doom_one_plugin_indent_blankline = true
vim.g.doom_one_plugin_vim_illuminate = true
vim.g.doom_one_plugin_lspsaga = true

vim.cmd("set termguicolors")
vim.cmd("colorscheme doom-one")

local function set_hl(group, values)
	vim.api.nvim_set_hl(0, group, values)
end

local colors = require("doom-one.colors")
local current_bg = vim.opt.background:get()
local palette = colors.get_palette(current_bg)
set_hl("LineNr", { bg = palette.bg, fg = palette.yellow })
set_hl("CursorLineNr", { bg = palette.bg, fg = palette.yellow })
