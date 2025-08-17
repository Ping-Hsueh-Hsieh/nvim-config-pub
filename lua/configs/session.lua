local finders = require("telescope.finders")

local function joinpath(...)
  return (table.concat({ ... }, '/'):gsub('//+', '/'))
end

-- load session
local actions = require("telescope.actions")

local action_state = require("telescope.actions.state")
-- local sessionDir = "C:\\Users\\HPH\\.config\\nvim-data\\vimSession\\"
local sessionDir = joinpath("C:", "Users", "HPH", ".config", "nvim-data", "vimSession")

-- finder cmd
local finder_cmd = {
    "fd",
    ".",
    sessionDir
}

-- enter session
local function load_session(prompt_bufnr)
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    -- source session  :source <session-file>
    vim.cmd([[
    bufdo bwipe
    source ]] .. selection[1])
end

-- overwrite_session from telescope
local function overwrite_session(prompt_bufnr)
    vim.ui.input(
        { prompt = "Overwrite the session file? (y/n): " },
        function(input)
            if input == "y" then
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd([[mks! ]] .. selection[1])
                -- vim.print(" ")
                -- vim.print("Overwrite session file: " .. selection[1])
            end
        end
    )
end

local function create_session (prompt_bufnr)
    local curr_picker = action_state.get_current_picker(prompt_bufnr)
    local session_filename = curr_picker:_get_prompt()
    local session_file = joinpath(sessionDir, session_filename)

    vim.ui.input(
        { prompt = "Create the session file ".. session_file .. "? (y/n): " },
        function(input)
            if input == "y" then
                actions.close(prompt_bufnr)
                vim.cmd([[mks ]] .. session_file)
                -- vim.print(" ")
                -- vim.print("Create session file: " .. session_file)
            end
        end
    )
end

-- 删除选中session
local function delete_selection(prompt_bufnr, _)
    local selection = action_state.get_selected_entry()

    -- increase the cmdheight for stupid "Press ENTER ..."
    local ori_height = vim.o.cmdheight
    vim.o.cmdheight = 6
    vim.cmd([[! cmd /C del "]] .. selection[1] .. "\"")
    vim.o.cmdheight = ori_height

    local curr_picker = action_state.get_current_picker(prompt_bufnr)
    local opts = {
        -- attach_mappings绑定的键位映射只生效于telescope的buffer，不影响全局
        attach_mappings = function(_, map)
            -- <enter>键 进入选中session
            map("n", "l", load_session)
            -- save
            map("n", "s", overwrite_session)
            -- d键 删除选中session
            map("n", "d", delete_selection)
            -- create session
            map("i", "<CR>", create_session)
            return true
        end,
    }
    curr_picker:refresh(finders.new_oneshot_job(finder_cmd, opts), {})
end


local manage_session = function()
    local opts = {
        -- attach_mappings绑定的键位映射只生效于telescope的buffer，不影响全局
        attach_mappings = function(_, map)
            -- <enter>键 进入选中session
            map("n", "l", load_session)
            -- save
            map("n", "s", overwrite_session)
            -- d键 删除选中session
            map("n", "d", delete_selection)
            -- create session
            map("i", "<CR>", create_session)
            return true
        end,
        -- 定义Finder的查找命令为ls <session-file所在的目录>
        find_command = finder_cmd,
        prompt_title = "Manage session",
    }
    require("telescope.builtin").find_files(opts)
end


vim.keymap.set("n", "<leader>ms", manage_session)

-- 将telescope会话管理包装为用户定义命令
vim.api.nvim_create_user_command("LoadSession", manage_session, { desc = "load user session,like workspace" })
