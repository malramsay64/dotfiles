local nvim_lsp = require('lspconfig')
local completion = require('completion')
require("nvim_utils")

--- Function defining how we attach to a language server
-- This is all the functionality associated with the langauge server protocol.
local custom_attach = function(client)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    completion.on_attach(client)
    -- On write automatically format buffer
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
    end

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

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

nvim_lsp.sumneko_lua.setup({
    cmd = {
        sumneko_binary,
        "-E",
        sumneko_root_path .. "/main.lua"
    },
    on_attach=custom_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
            completion = { keywordSnippet = "Disable", },
            diagnostics = { enable = true, globals = {
                "vim", "describe", "it", "before_each", "after_each", "use" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    }
})

nvim_lsp.vimls.setup({
    on_attach=custom_attach
})

nvim_lsp.rust_analyzer.setup({on_attach=custom_attach})
nvim_lsp.pyls_ms.setup({on_attach=custom_attach})
nvim_lsp.tsserver.setup({on_attach=custom_attach})
nvim_lsp.r_language_server.setup({on_attach=custom_attach})
nvim_lsp.clangd.setup({
    on_attach=custom_attach,
    filetypes={ "c", "cpp", "objc", "objcpp", "cuda" },
})
nvim_lsp.html.setup({on_attach=custom_attach})

require('lsp_extensions').inlay_hints{
        highlight = "Comment",
        prefix = " > ",
        aligned = true,
        only_current_line = false
}

vim.cmd("autocmd BufEnter *.md lua require'completion'.on_attach()")

