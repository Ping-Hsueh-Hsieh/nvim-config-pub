-- lua/configs/nvim_dap.lua

local status, dap = pcall(require, "dap")
if not status then
    return
end

local dap_ui_widgets = require("dap.ui.widgets")

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "python"
        end,
    },
}

dap.adapters.codelldb = {
    type = 'server',
    host = "localhost",
    port = "${port}",
    executable = {
        command = vim.fn.getenv("HOME") .. "/.local/bin/codelldb/adapter/codelldb",
        args = {"--port", "${port}"},
    }
}

for _, lang in ipairs({ "c", "cpp", "rust" }) do
    dap.configurations[lang] = {
        {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
        {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            pid = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }
end

vim.keymap.set("n", "<F1>", function()
    dap.continue()
end, { desc = "DAP_continue()" })
vim.keymap.set("n", "<F2>", function()
    dap.step_into()
end, { desc = "DAP_step_into()" })
vim.keymap.set("n", "<F3>", function()
    dap.step_over()
end, { desc = "DAP_step_over()" })
vim.keymap.set("n", "<F4>", function()
    dap.step_out()
end, { desc = "DAP_step_out()" })
vim.keymap.set("n", "<F5>", function()
    dap.run_to_cursor()
end, { desc = "DAP_run_to_cursor" })
vim.keymap.set("n", "<F6>", function()
    dap.restart()
end, { desc = "DAP_restart()" })

vim.keymap.set("n", "<Leader>db", function()
    dap.toggle_breakpoint()
end, { desc = "DAP_toggle_breakpoint()" })

vim.keymap.set("n", "<Leader>dr", function()
    dap.repl.open()
end, { desc = "DAP_repl.open()" })

vim.keymap.set("n", "<leader>dt", function()
    dap.terminate()
end, { desc = "DAP_terminate" })

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    dap_ui_widgets.hover()
end, { desc = "DAP_hover()" })
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
    dap_ui_widgets.preview()
end, { desc = "DAP_preview()" })

--NOTE: key collision with `trouble`
-- vim.keymap.set("n", "<Leader>df", function()
--     local widgets = require("dap.ui.widgets")
--     widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
--     local widgets = require("dap.ui.widgets")
--     widgets.centered_float(widgets.scopes)
-- end)
