vim.filetype.add({
    extension = {
        tlc = 'matlab',
        m = 'matlab',
        cgt = 'matlab',
    }
})

-- CANOE
vim.filetype.add({
    extension = {
        cin = 'capl',
        can = 'capl',
    }
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.py", "*.md" },
    callback = function()
        vim.treesitter.start()
    end,
})
