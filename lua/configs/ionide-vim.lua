-- lua/configs/ionide-vim.lua

local status, iv = pcall(require, "Ionide")

if not status then
    return
end

iv.setup({})
