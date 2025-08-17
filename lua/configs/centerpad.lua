-- lua/configs/centerpad.lua

local status, cpd = pcall(require, "centerpad")
if not status then
    return
end

vim.keymap.set({"n"}, "<leader>z", "<CMD>Centerpad 50<CR>", { silent = true, noremap = true })
