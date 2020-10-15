local nvim_lsp = require('nvim_lsp')
local completion = require('completion')

require "nvim_utils"

--- Function defining how we attach to a language server
-- This is all the functionality associated with the langauge server protocol.
local custom_attach = function(client)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    completion.on_attach(client)
    -- On write automatically format buffer
    vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]])

    -- vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
    BufMapper("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
    BufMapper("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    BufMapper("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    BufMapper("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    BufMapper("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    BufMapper("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    BufMapper("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    BufMapper("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    BufMapper("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

nvim_lsp.sumneko_lua.setup({
    cmd = {
        "~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
        "-E",
        "~/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
    },
    on_attach=custom_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = "Disable", },
            diagnostics = { enable = true, globals = {
                "vim", "describe", "it", "before_each", "after_each" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("~/build/neovim/src/nvim/lua")] = true,
                },
            },
        },
    }
})

nvim_lsp.vimls.setup({
    on_attach=custom_attach
})

nvim_lsp.rust_analyzer.setup({on_attach=custom_attach})
nvim_lsp.pyls.setup({on_attach=custom_attach})
nvim_lsp.r_language_server.setup({on_attach=custom_attach})
nvim_lsp.clangd.setup({
    on_attach=custom_attach,
    filetypes={ "c", "cpp", "objc", "objcpp", "cuda" },
})

vim.cmd("autocmd BufEnter *.md lua require'completion'.on_attach()")

