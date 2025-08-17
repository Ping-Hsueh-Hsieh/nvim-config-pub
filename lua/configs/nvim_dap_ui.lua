-- lua/configs/nvim_dap_ui.lua

local status, dapui = pcall(require, "dapui")
if not status then
    return
end

dapui.setup()

local dap = require("dap")

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
