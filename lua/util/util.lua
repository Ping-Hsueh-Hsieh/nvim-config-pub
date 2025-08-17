local M = {}

local oil_status, oil = pcall(require, "oil")
local on_exit = function(_, exit_code, _)
    if exit_code == 0 then
        print("Command executed successfully!")
    else
        print("Command execution failed with code: " .. exit_code)
    end
end

---@return string path Directory path
M.get_curr_dir = function ()
    local path = nil
    if oil_status then
        path = oil.get_current_dir()
    end
    if path == nil then
        path = vim.fn.expand('%:p:h')
    end
    return path
end

---@param bufname string Name of the buffer created by this function
---@param use_curr_path boolean true: use the current directory; false: use `vim.uv.cwd()`
M.create_prompt = function (bufname, use_curr_path)
    local prompt
    if use_curr_path then
         prompt = "Compc> "
    else
         prompt = "Compo> "
    end

    local cwd = vim.uv.cwd()
    if use_curr_path then
        cwd = M.get_curr_dir()
    end
    print(string.format("Creating terminal @ [%s]", cwd))

    -- fetch inputs
    local input = vim.fn.input(prompt)
    vim.cmd("redraw!") -- clear out the current command bar text
    if input == "" then return end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if string.find(name, bufname) then

            local term_job_id = vim.b[buf] and vim.b[buf].terminal_job_id

            if term_job_id then
                local pid = vim.fn.jobpid(term_job_id)
                -- print(string.format("removing term job(%d) pid(%d)", term_job_id, pid))
                vim.uv.kill(pid, "sigkill")
                local cmd = string.format("bw!*%d*", pid)
                vim.cmd(cmd)
            end

            local cmd = string.format("bw!%s", bufname)
            -- print(string.format("romeving buffer: %s -> %s with command %s", bufname, name, cmd))
            vim.cmd(cmd)

            break
        end
    end

    -- create a tab
    vim.cmd("tabnew")

    -- create the zsh instance
    local term_id = vim.fn.termopen("zsh", {
        on_exit = on_exit,
        cwd=cwd,
    })
    -- print(string.format("creating terminal with id: %d", term_id))
    vim.b.terminal_job_id = term_id

    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(buf, bufname)

    -- execute the command
    local cmd = input .. "\r" -- pressing enter to execute the command
    vim.api.nvim_chan_send(term_id, cmd)
end

M.show_bufs = function ()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        print("buffer name: " .. name)
    end
end

return M
