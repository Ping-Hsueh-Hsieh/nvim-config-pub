-- 📂lua/🌑settings.lua

local global = vim.g
local o = vim.o
local wo = vim.wo

vim.scriptencoding = "utf-8"

-- Map <leader>

global.mapleader = " "
global.maplocalleader = " "

-- Editor options

o.number = true             -- Print the line number in front of each line
o.relativenumber = true     -- Show the line number relative to the line with the cursor in front of each line.
-- o.clipboard = "unnamedplus" -- uses the clipboard register for all operations except yank.
o.syntax = "on"             -- When this option is set, the syntax with this name is loaded.
o.autoindent = true         -- Copy indent from current line when starting a new line.
o.cursorline = true        -- Highlight the screen line of the cursor with CursorLine.
o.expandtab = true          -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 4            -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 4               -- Number of spaces that a <Tab> in the file counts for.
o.softtabstop = 4
o.encoding = "utf-8"        -- Sets the character encoding used inside Vim.
o.fileencoding = "utf-8"    -- Sets the character encoding for the file of this buffer.
o.ruler = true              -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "a"               -- Enable the use of the mouse. "a" you can use on all modes
o.title = true              -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true             -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0           -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true           -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true            -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true          -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split"      -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.scrolloff = 20

vim.opt.breakindent = true
vim.o.swapfile = false

vim.opt.hlsearch = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = false
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.zig_fmt_autosave = 0

vim.cmd("set isfname-=:")

-- "Press ENTER or type command to continue"
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this is caused by the cmdheight is not enough to print all the messages from command line
-- vvvvvvvvvvvvvvv this can modify the command line height for workaround
-- o.cmdheight = 1

-- Window options
wo.wrap = false

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup("my-settings", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
