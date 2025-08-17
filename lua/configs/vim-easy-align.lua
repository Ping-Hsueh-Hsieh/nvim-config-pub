-- lua/configs/vim-easy-align.lua

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("v", "ga", ":EasyAlign<CR>")
