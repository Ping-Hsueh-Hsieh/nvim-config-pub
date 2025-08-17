-- lua/configs/rustaceanvim.lua
vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
        float_win_config = {
            border = 'rounded',
        },
    },
    -- LSP configuration
    -- server = {
    --     on_attach = function(client, bufnr)
    --         -- you can also put keymaps in here
    --     end,
    --     default_settings = {
    --         -- rust-analyzer language server configuration
    --         ["rust-analyzer"] = {},
    --     },
    -- },
    -- DAP configuration
    -- dap = {},
}
