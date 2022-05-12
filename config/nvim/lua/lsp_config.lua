local lsp_extensions = require("lsp_extensions")
local lsp_format = require("lsp-format")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- These are capabilities for completion
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--- Function defining how we attach to a language server
-- This is all the functionality associated with the langauge server protocol.
local custom_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    -- vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
    lsp_format.on_attach(client)

    lsp_extensions.inlay_hints({
        aligned = true,
        enabled = { "TypeHint", "ChainingHint", "ParameterHint" },
        prefix = "» ",
    })

    -- Set some keybinds conditional on server capabilities
    vim.keymap.set("n", "<space>lf", vim.lsp.buf.formatting, opts)

    vim.api.nvim_create_autocmd("CursorHold", { buffer = 0, callback = vim.diagnostic.open_float })

    vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)

    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "<space>ld", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist, opts)
end

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
        },
    },
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = custom_attach,
    }

    if server.name == "zk" then
        return
    end
    if server.name == "sumneko_lua" then
        opts.settings = lua_settings
    end
    if server.name == "cpp" then
        opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    end

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
end)
