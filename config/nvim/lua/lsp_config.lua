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

      -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        BufMapper("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    elseif client.resolved_capabilities.document_range_formatting then
        BufMapper("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    end

    vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
    BufMapper("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
    BufMapper('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    BufMapper('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    BufMapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

    BufMapper("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    BufMapper("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    BufMapper("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

    BufMapper("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    BufMapper("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    BufMapper("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    BufMapper("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

    BufMapper('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    BufMapper('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

    BufMapper('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    BufMapper('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    BufMapper('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    BufMapper('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    BufMapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    BufMapper('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    BufMapper('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
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
local sumneko_root_path = vim.fn.stdpath('cache')..'/nlua/sumneko_lua/lua-language-server'
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
nvim_lsp.pyls.setup({
    enable = true,
    on_attach=custom_attach,
    settings = {
        pyls = {
            configurationSources = {"flake8", "isort"},
            plugins = {
                pydocstyle = {enabled = true},
                pycodestyle = {enabled = true},
                flake8 = {enabled = true},
                pyls_black = {enabled = true},
                pyls_isort = {enabled = true},
                pyls_mypy = {
                    enabled = true,
                    live_mode = true,
                },
                jedi_completion = {fuzzy = true},
                yapf = {enabled = false}

            }
        }
    },
})
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

