local config = {}

-- Statusline {{{

config.bubbly = function()
    vim.g.bubbly_statusline = {
        "mode",
        "truncate",
        "branch",
        "signify",
        "path",
        "divisor",
        "builtinlsp.diagnostic_count",
        "filetype",
        "progress",
    }

    vim.g.bubbly_palette = {
        background = "#34343c",
        foreground = "#c5cdd9",
        black = "#3e4249",
        red = "#ec7279",
        green = "#a0c980",
        yellow = "#deb974",
        blue = "#6cb6eb",
        purple = "#d38aea",
        cyan = "#5dbbc1",
        white = "#c5cdd9",
        lightgrey = "#57595e",
        darkgrey = "#404247",
    }
end

-- }}}
-- fugitive {{{

config.fugitive = function()
    -- Open a fugitve window in a vertical split on the right hand side of the window
    Mapper("n", "<space>gs", ":vertical rightbelow Git<CR>")
end

-- }}}
-- Completion {{{

config.completion = function()
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
        },
    })
end

-- }}}
-- telescope {{{

config.telescope = function()
    Mapper("n", "<space>p", "<cmd>lua require('telescope.builtin').git_files{}<CR>")
    Mapper("n", "<space>f", "<cmd>lua require('telescope.builtin').find_files{}<CR>")
    Mapper("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>")
    Mapper(
        "n",
        "<space>gr",
        "<cmd>lua require('telescope.builtin').lsp_references{}<CR>"
    )
    Mapper(
        "n",
        "<space>en",
        "<cmd>lua require('telescope.builtin').git_files{cwd = '~/dotfiles'}<CR>"
    )
    Mapper("n", "<space>gg", "<cmd>lua require('telescope.builtin').live_grep{}<CR>")
    Mapper("n", "<space>tc", "<cmd>lua require('telescope.builtin').commands{}<CR>")
    Mapper("n", "<space>tr", "<cmd>lua require('telescope.builtin').registers{}<CR>")
    Mapper("n", "<space>ta", "<cmd>lua require('telescope.builtin').autocommands{}<CR>")
    Mapper("n", "<space>tk", "<cmd>lua require('telescope.builtin').keymaps{}<CR>")
    Mapper(
        "n",
        "<space>tl",
        "<cmd>lua require('telescope.builtin').lsp_code_actions{}<CR>"
    )

    Mapper("n", "<space>gb", "<cmd>lua require('telescope.builtin').git_branches{}<CR>")
    Mapper("n", "<space>gt", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
    Mapper("n", "<space>gd", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
end

-- }}}
-- formatter {{{

config.formatter = function()
    require("format").setup({
        ["*"] = {
            { cmd = { "sed -i 's/[ \t]*$//'" } }, -- remove trailing whitespace
        },
        -- This uses the local versions of these packages to work within a project.
        python = {
            { cmd = { "black" } },
            { cmd = { "isort", "--filter-files" } },
        },
        markdown = {
            {
                cmd = { "black" },
                start_pattern = "^```python",
                end_pattern = "^```",
                target = "current",
            },
        },
        typescript = {
            { cmd = { "prettier --write " } },
        },
        html = {
            { cmd = { "prettier --write " } },
        },
        css = {
            { cmd = { "prettier --write " } },
        },
        lua = {
            {cmd = {"stylua" }},
        },
    })

    nvim_create_augroups({
        formatting = {
            { "BufWritePost", "*", "FormatWrite" },
        },
    })
end

-- }}}
-- LSP {{{

config.lsp_install = function()
    for lang in { "python", "typescript", "lua", "yaml", "vim" } do
        require("lspinstall").install_server(lang)
    end
end

-- }}}
-- Code Outline {{{
config.outline = function()
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false, -- experimental
        position = "right",
        keymaps = {
            close = "<Esc>",
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            rename_symbol = "r",
            code_actions = "a",
        },
    }
end

--}}}
--- LSP Installation {{{

config.install_lsp_servers = function()
    local language_servers = {
        "angular",
        "bash",
        "cmake",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "json",
        "latex",
        "lua",
        "python",
        "rust",
        "tailwindcss",
        "typescript",
        "yaml",
    }
    for _, server in pairs(language_servers) do
        require("lspinstall").install_server(server)
    end
end

--}}}
--- Autoclose Pairs {{{

config.pears = function()
    require("pears").setup(function(conf)
        conf.pair("<", { filetypes = { "typescript" } })
        conf.on_enter(function(pears_handle)
            if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
                return vim.fn["compe#confirm"]("<CR>")
            else
                pears_handle()
            end
        end)
    end)
end

-- }}}
-- Snippets

config.snippets = function()
    Mapper("i", "<C-k>", "<cmd>lua require('luasnip').jump(1)<CR>")
    Mapper("i", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>")
    Mapper("s", "<C-k>", "<cmd>lua require('luasnip').jump(1)<CR>")
    Mapper("s", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>")
end

return config
