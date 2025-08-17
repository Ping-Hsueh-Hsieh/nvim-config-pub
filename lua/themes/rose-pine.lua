-- file: lua/themes/rose-pine.lua

local status, r = pcall(require, "rose-pine")
if not status then
    return
end

r.setup({
    -- dim_inactive_windows = true,
    styles = {
        bold = true,
        italic = false,
        transparency = true,
    },
    highlight_groups = {
        ["Normal"] = { bg = "NONE" },
        ["NormalFloat"] = { bg = "NONE" }
    },
})

vim.cmd("colorscheme rose-pine")
