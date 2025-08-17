-- 📂lua/📂configs/🌑tresitter.lua

local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

ts.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        -- disable = { "elixir" },
        -- disable = { "c", "rust" },
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    ensure_installed = {
        -- "elixir",
        -- "eex",
        -- "heex",
        -- "xml",
        -- "markdown",
        -- "toml",
        -- "c",
        -- "cpp",
        -- "c_sharp",
        -- "json",
        -- "yaml",
        -- "rust",
        -- "lua",
        "python",
        "kdl",
        -- "ocaml",
        -- "ocaml_interface",
        -- "proto",
        -- "ocamllex",
    },
    rainbow = {
        enable = true,
        disable = { "html" },
        extended_mode = true,
        max_file_lines = nil,
    },
    autotag = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = true },
})

