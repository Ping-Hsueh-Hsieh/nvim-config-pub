-- lua/configs/telescope.lua

local status, nvim_telescope = pcall(require, "telescope")
if not status then
    return
end

nvim_telescope.setup({
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
        ['fzf'] = {},
    },
    defaults = {
        mappings = {
            n = {
                ['d'] = require('telescope.actions').delete_buffer
            },
        }, -- mappings
    },     -- defaults
})

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require("telescope.builtin")

-- Telescope
vim.keymap.set("n", "<leader>fa", "<CMD>Telescope find_files hidden=true<CR>", { desc = "get all files include hidden" }) -- Get all files
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" }) -- Get filse in the git cache
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
-- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
    -- builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, })
    builtin.current_buffer_fuzzy_find()
end, { desc = '[/] Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
builtin.live_grep {
  grep_open_files = true,
  prompt_title = 'Live Grep in Open Files',
}
end, { desc = '[S]earch [/] in Open Files' })

require("configs.telescope.multigrep").setup()
