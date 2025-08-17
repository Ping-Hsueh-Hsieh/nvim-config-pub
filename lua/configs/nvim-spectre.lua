-- lua/configs/nvim-spectre.lua

local status, plugin = pcall(require, "spectre")
if not status then
    return
end

plugin.setup({})

