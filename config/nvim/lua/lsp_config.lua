local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
local lsp_extensions = require('lsp_extensions')
local lsp_install = require('lspinstall')

require("nvim_utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- These are capabilities for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
-- This is for lsp status
capabilities.window = capabilities.window or {}
capabilities.window.workDoneProgress = true

-- Register the process handler
lsp_status.register_progress()

--- Function defining how we attach to a language server
-- This is all the functionality associated with the langauge server protocol.
local custom_attach = function(client)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    lsp_status.on_attach(client)
    lsp_extensions.inlay_hints({ enabled = {"TypeHint", "ChainingHint", "ParameterHint"} })

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

    BufMapper('n', '<space>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    BufMapper('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    BufMapper('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

    -- BufMapper('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    -- BufMapper('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    -- BufMapper('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    BufMapper('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    BufMapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    BufMapper('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    BufMapper('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

lsp_install.setup() -- important

local servers = lsp_install.installed_servers()
for _, server in pairs(servers) do
    local config = {
        capabilities=capabilities,
        on_attach=on_attach,
    }
    if server == "lua" then
        config.settings = lua_settings
    end
    if server == "cland" then
        config.filetypes={ "c", "cpp", "objc", "objcpp", "cuda" }
    end

    nvim_lsp[server].setup(config)
end

-- vim.cmd("autocmd BufEnter * lua require('completion').on_attach()")
