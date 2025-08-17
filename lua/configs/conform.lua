-- ./lua/configs/conform.lua
local status, conform = pcall(require, "conform")
if not status then
    return
end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
    },
})
