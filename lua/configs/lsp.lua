-- 📂lua/📂configs/🌑lsp.lua

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)

        -- enable inlay hints
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client ~= nil then
        --     if client.server_capabilities.inlayHintProvider then
        --         vim.lsp.inlay_hint.enable(true)
        --     end
        -- end

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        local vmap = function(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("K", function()
            vim.lsp.buf.hover({border = 'rounded'})
        end, "Hover Documentation")
        map("<leader>k", vim.lsp.buf.signature_help, "Signature help")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("==", function()
            -- vim.lsp.buf.format({ async = true })
            require("conform").format({ lsp_fallback = true, bufnr = ev.buf, async = true })
        end, "lsp format")
        vmap("=", function ()
            -- vim.lsp.buf.format({ bufnr=ev.buf, async = true })
            require("conform").format({ lsp_fallback = true, bufnr = ev.buf, async = true })
        end, "Visual Selection Format")
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- NOTE: rust-analyzer is set up by `rustaceanvim`

local texlab_opt = {
    capabilities = capabilities,
    settings = {
        texlab = {
            auxDirectory = ".",
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                args = {},
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
    single_file_support = true,
}

local pyright_opt = {
    autostart=false,
    settings = {
        pyright = {
            typeCheckingMode = "standard", -- ["off", "basic", "standard", "strict"]
            exclude = {
                "node_modules",
                "venv",
                "**/__pycache__",
            },
        },
    },
    capabilities = capabilities,
}

local clangd_opt = {
    cmd = { "clangd", "--completion-style=detailed" },
    capabilities = capabilities,
}

local zls_opt = {
    settings = {
        enable_autofix = false,
    },
    capabilities = capabilities,
}

local lua_ls_opt = {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                },
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            format = {
                enable = false,
                default_capabilities = {
                    indent_style = "space",
                    indent_size = 2,
                },
            },
        },
    },
    capabilities = capabilities,
}

local html_opt = {
}

local sourcekit_opt = {
    filetypes = {
        "swift",
    },
}

---@class Setting
---@field name string
---@field opt any

---@type Setting[]
local settings = {
    {
        name = "texlab",
        opt = texlab_opt,
    },
    {
        name = "pyright",
        opt = pyright_opt,
    },
    {
        name = "clangd",
        opt = clangd_opt,
    },
    {
        name = "zls",
        opt = zls_opt,
    },
    {
        name = "lua_ls",
        opt = lua_ls_opt,
    },
    {
        name = "html",
        opt = html_opt,
    },
    {
        name = "sourcekit",
        opt = sourcekit_opt,
    },
}

for _, setting in ipairs(settings) do
    vim.lsp.config(setting.name,setting.opt)
    vim.lsp.enable(setting.name)
end
