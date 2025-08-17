-- 📂lua/🌑maps.lua

local function map(mode, lhs, rhs, opt)
    opt = opt or {}
    opt.silent = false
    vim.keymap.set(mode, lhs, rhs, opt)
end

map("v", "<leader>e", "<CMD>s/.*/\\=eval(submatch(0))<CR>")
map("n", "<leader>o", "<CMD>Oil<CR>", {desc = "[O]pen current directory"})

-- map("t", "<C-w>", "<C-\\><C-n><C-w>")
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- compilation mode
local util = require("util.util")
vim.keymap.set("n", "<leader>cc", function()
    util.create_prompt("--compilation_mode--", false)
end)

-- vim-visual-multi
require("configs.vim_visual_multi")

-- -- nvim-spectre
-- --
-- map('n', '<leader>s', '<cmd>lua require("spectre").toggle()<CR>', {
--     desc = "Toggle Spectre"
-- })
-- map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--     desc = "Search current word"
-- })
-- map('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--     desc = "Search current word"
-- })
-- map('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--     desc = "Search on current file"
-- })

-- Terminal
-- map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
-- map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")

-- Markdown Preview
map("n", "<leader>m", "<CMD>MarkdownPreview<CR>", { desc = "MarkdownPreview" })
map("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>", { desc = "MarkdownPreviewStop" })

-- Window Navigation
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><", { desc = "resize left" })
map("n", "<C-Right>", "<C-w>>", { desc = "resize right" })
map("n", "<C-Up>", "<C-w>+", { desc = "resize up" })
map("n", "<C-Down>", "<C-w>-", { desc = "resize down" })

-- Indent/Outdent
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Noh
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Quitall
map("n", "<leader>q", "<CMD>quitall!<CR>", { desc = "quit all force" })

-- p as P: paste will not override the buffer
map("x", "p", "P")

map({ "n", "v" }, "<leader>p", [["+p]])
map({ "n", "v" }, "<leader>y", [["+y]])

-- Alt move lines
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
-- map("n", "<A-j>", ":m .+1<CR>==")
-- map("n", "<A-k>", ":m .-2<CR>==")
-- map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- TABS
map("n", "<M-l>", "<CMD>tabnext<CR>")
map("n", "<M-h>", "<CMD>tabprevious<CR>")
map("n", "<M-n>", "<CMD>tabnew<CR>")
map("n", "<M-c>", "<CMD>tabclose<CR>")

map("t", "<M-l>", "<C-\\><C-n><CMD>tabnext<CR>")
map("t", "<M-h>", "<C-\\><C-n><CMD>tabprevious<CR>")
map("t", "<M-n>", "<C-\\><C-n><CMD>tabnew<CR>")
map("t", "<M-c>", "<C-\\><C-n><CMD>tabclose<CR>")

map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")
map("i", "<C-a>", "<Esc>I")
map("i", "<C-e>", "<End>")
map("i", "<M-b>", "<Esc>bi")
map("i", "<M-f>", "<Esc>lwi")

-- diagnostics with trouble instead of vim.diagnostics

local tb_st, tb = pcall(require, "trouble")
if not tb_st then
    -- `trouble.nvim` is not found, use vim.diagnostics
    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "vim.diagnostic.open_float" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "vim.diagnostic.goto_prev" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "vim.diagnostic.goto_next" })
    vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "vim.diagnostic.setloclist" })
else
    vim.keymap.set("n", "<leader>dw",
        "<CMD>Trouble diagnostics toggle<CR>",
        { desc = "Diagnostics (Trouble)" })
    vim.keymap.set("n", "<leader>dd",
        "<CMD>Trouble diagnostics toggle filter.buf=0 focus=true<CR>",
        { desc = "Buffer Diagnostics (Trouble)" })
    vim.keymap.set("n", "<leader>df",
        function()
            tb.focus()
        end,
        { desc = "Buffer Diagnostics (Trouble)" })
    vim.keymap.set("n", "[d",
        function()
            tb.prev({mode='diagnostics', jump=true})
        end,
        { desc = "tb.prev({mode='diagnostics', jump=true})" })
    vim.keymap.set("n", "]d",
        function()
            tb.next({mode='diagnostics', jump=true})
        end,
        { desc = "tb.next({mode='diagnostics', jump=true})" })
    vim.keymap.set("n", "]f",
        function()
            tb.first({mode='diagnostics', jump=true})
        end,
        { desc = "tb.first({mode='diagnostics', jump=true})" })
end
