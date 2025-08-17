-- ./lua/configs/indent-blankline.lua
local status, ibl = pcall(require, "ibl")
if not status then
    return
end

ibl.setup({
    scope = {
        enabled = false,
        -- show_start = false,
        -- show_end = false,
        -- highlight = { "Function", "Label" },
    },
})
