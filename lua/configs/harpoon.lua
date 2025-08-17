-- ./lua/configs/harpoon.lua
local status, harpoon = pcall(require, "harpoon")
if not status then
    return
end

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc="[H]arpoon [add]"})
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc="[H]arpoon [L]ist"})

-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

