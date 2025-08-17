-- lua/configs/nvim_dap_python.lua
local status, dap_python = pcall(require, "dap-python")
if not status then
    return
end

dap_python.setup("python")
