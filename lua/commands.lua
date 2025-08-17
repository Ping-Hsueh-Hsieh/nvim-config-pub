-- ./lua/commands.lua

local util = require("util.util")

local setPlusAnd0Register = function(content)
    vim.fn.setreg('"', content)
    vim.fn.setreg('+', content)
end

vim.api.nvim_create_user_command('D', function()
    setPlusAnd0Register(util.get_curr_dir())
end, {desc='copy current directory to clipboard'})

vim.api.nvim_create_user_command(
    "Comp",
    function ()
        util.create_prompt("--compilation_mode--", false)
    end,
    {desc="Compilation mode with path=<vim.uv.cwd()>"}
)

vim.api.nvim_create_user_command(
    "Compc",
    function ()
        util.create_prompt("--compilation_mode--", true)
    end,
    {desc="Compilation mode with path=<current directory of a file or oil instance>"}
)
