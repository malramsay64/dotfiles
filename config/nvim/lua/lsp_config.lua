local lsp_extensions = require("lsp_extensions")
local lsp_signature = require("lsp_signature")

require("nvim_utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- These are capabilities for completion
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--- Function defining how we attach to a language server
-- This is all the functionality associated with the langauge server protocol.
local custom_attach = function(client)
    vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
    lsp_signature.on_attach(client)

    lsp_extensions.inlay_hints({
        aligned = true,
        enabled = { "TypeHint", "ChainingHint", "ParameterHint" },
        prefix = "» ",
    })

    -- On write automatically format buffer
    if client.resolved_capabilities.document_formatting then
        vim.cmd(
            "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)"
        )
    end

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        BufMapper("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    elseif client.resolved_capabilities.document_range_formatting then
        BufMapper("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end

    vim.api.nvim_command(
        "autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()"
    )

    BufMapper("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
    BufMapper("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    BufMapper("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    BufMapper("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")

    BufMapper("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    BufMapper("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    BufMapper("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    BufMapper("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

    BufMapper("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    BufMapper("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    BufMapper("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    BufMapper("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

    BufMapper(
        "n",
        "<space>ld",
        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
    )
    BufMapper("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    BufMapper("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    BufMapper("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
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

    if server.name == "lua" then
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
