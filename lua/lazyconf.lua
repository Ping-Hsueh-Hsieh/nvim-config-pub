-- lua/lazyconf.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    ------------------------------
    --- basics
    ------------------------------
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    ------------------------------
    --- themes
    ------------------------------
    {
        "NTBBloodbath/doom-one.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
    },

    ------------------------------
    --- status line
    ------------------------------
    {
        "echasnovski/mini.nvim",
        config = function()
            require("configs.mini")
        end,
    },

    ------------------------------
    --- filesystem
    ------------------------------
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     config = function()
    --         require("configs.nvim-tree")
    --     end,
    --     dependencies = {
    --         "nvim-tree/nvim-web-devicons", -- optional
    --     },
    -- },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("configs.oil")
        end,
    },

    ------------------------------
    --- essentials
    ------------------------------
    {
        "numToStr/Comment.nvim",
        config = function()
            require("configs.comment")
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        config = function()
            require("configs.todo")
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- {
    --     "j-hui/fidget.nvim",
    --     config = function()
    --         require("configs.fidget")
    --     end,
    -- },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.gitsigns")
        end,
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    {
        "mbbill/undotree",
        config = function()
            require("configs.undotree")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("configs.harpoon")
        end,
    },
    {
        "mg979/vim-visual-multi",
        event = "VimEnter",
        lasy = false,
        branch = "master",
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        config = function()
            require("configs.telescope")
        end,
    },
    {
        "junegunn/vim-easy-align",
        event = "VimEnter",
        config = function()
            require("configs.vim-easy-align")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("configs.indent-blankline")
        end,
    },
    ------------------------------
    --- Search
    ------------------------------
    -- {
    --     "nvim-pack/nvim-spectre",
    --     config = function()
    --         require("configs.nvim-spectre")
    --     end,
    -- },

    ------------------------------
    --- diagnostics
    ------------------------------
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("configs.trouble")
        end,
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = require("configs.dadbob_ui").init,
        config = require("configs.dadbob_ui").config,
    },

    ------------------------------
    --- autocompletion
    ------------------------------
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("configs.cmp")
        end,
    },

    ------------------------------
    --- formating
    ------------------------------
    {
        "stevearc/conform.nvim",
        config = function()
            require("configs.conform")
        end,
    },

    ------------------------------
    --- LSP
    ------------------------------
    { "onsails/lspkind-nvim" },
    {
        "mrcjkb/rustaceanvim",
        config = function()
            require("configs.rustaceanvim")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("configs.treesitter")
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- "williamboman/mason.nvim",
            -- "williamboman/mason-lspconfig.nvim",
            -- "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- "j-hui/fidget.nvim",
        },
        config = function()
            require("configs.lsp")
        end,
    },


    ------------------------------
    --- DAP
    ------------------------------

    {
        "mfussenegger/nvim-dap",
        config = function ()
            require("configs.nvim_dap")
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function ()
            require("configs.nvim_dap_ui")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        }
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function ()
            require("configs.nvim_dap_python")
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    }
})
