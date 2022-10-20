local lsp_extensions = require("lsp_extensions")
local lsp_format = require("lsp-format")

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }
require("mason").setup()

require('mason-lspconfig').setup({
    ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup({
        on_attach = custom_attach,
        capabilities = capabilities,
    })
end

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false, },
        },
    },
}
