vim.filetype.add({
    extension = {
        tlc = 'matlab',
        m = 'matlab',
        cgt = 'matlab',
    }
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.py", "*.md" },
    callback = function()
        vim.treesitter.start()
    end,
})
