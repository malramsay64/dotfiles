local config = {}
-- UltiSnips {{{

config.snippets = function()
    vim.g.UltiSnipsExpandTrigger = "<c-k>"
    vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "~/.config/.nvim/UltiSnips"}
    vim.g.ultisnips_python_style = "google"
end

-- }}}
-- Statusline {{{

config.bubbly = function()
    vim.g.bubbly_statusline = {
        'mode',
        'truncate',
        'branch',
        'signify',
        'path',
        'divisor',
        'lsp_status.diagnostics',
        'filetype',
        'progress',
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
    vim.g.completion_chain_complete_list = {
        default={
            {complete_items={"lsp", "snippet"}},
            {complete_items={"path"}, triggered_only={"/"}},
            {mode='<c-p>'},
            {mode='<c-n>'},
        },
    }

    vim.g.completion_trigger_keyword_length = 1
    vim.g.completion_enable_auto_paren = 1
    vim.g.completion_enable_snippet = "UltiSnips"
    vim.g.completion_trigger_on_delete = 1
    vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
end

config.completion = function()
    require('compe').setup ({
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
            border = "none", -- the border option is the same as `|help nvim_open_win|`
            winhighlight = "CompeDocumentation", -- highlight group used for the documentation window
            max_width = 120,
            min_width = 40,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1,
        };

        source = {
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = false;
            ultisnips = false;
            luasnip = false;
        };
    })
    vim.cmd([[inoremap <silent><expr> <C-Space> compe#complete()]])
    vim.cmd([[inoremap <silent><expr> <CR>      compe#confirm('<CR>')]])
    vim.cmd([[inoremap <silent><expr> <C-e>     compe#close('<C-e>')]])
    vim.cmd([[inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })]])
    vim.cmd([[inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })]])
    -- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true})
    -- vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", {expr = true})
    -- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    -- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
end

-- }}}
-- telescope {{{

config.telescope = function()
    Mapper("n", "<space>p", "<cmd>lua require('telescope.builtin').git_files{}<CR>")
    Mapper("n", "<space>f", "<cmd>lua require('telescope.builtin').find_files{}<CR>")
    Mapper("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>")
    Mapper("n", "<space>gr", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>")
    Mapper("n", "<space>en", "<cmd>lua require('telescope.builtin').git_files{cwd = '~/dotfiles'}<CR>")
    Mapper("n", "<space>gg", "<cmd>lua require('telescope.builtin').live_grep{}<CR>")
    Mapper("n", "<space>tc", "<cmd>lua require('telescope.builtin').commands{}<CR>")
    Mapper("n", "<space>tr", "<cmd>lua require('telescope.builtin').registers{}<CR>")
    Mapper("n", "<space>ta", "<cmd>lua require('telescope.builtin').autocommands{}<CR>")
    Mapper("n", "<space>tk", "<cmd>lua require('telescope.builtin').keymaps{}<CR>")
    Mapper("n", "<space>tl", "<cmd>lua require('telescope.builtin').lsp_code_actions{}<CR>")

    Mapper("n", "<space>gb", "<cmd>lua require('telescope.builtin').git_branches{}<CR>")
    Mapper("n", "<space>gt", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
    Mapper("n", "<space>gd", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
end

-- }}}
-- formatter {{{

config.formatter = function()
    require("format").setup({
        ["*"] = {
            {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
        },
        -- This uses the local versions of these packages to work within a project.
        python = {
            { cmd = {"black"} },
            { cmd = {"isort", "--filter-files"} },
        },
        lua = {
            {
                cmd = {
                    function(file)
                        return string.format("luafmt -l %s -w replace %s", vim.bo.textwidth, file)
                    end
                }
            }
        },
        markdown = {
            {
                cmd = {"black"},
                start_pattern = "^```python",
                end_pattern = "^```",
                target="current",
            }
        },
        typescript = {
            {cmd = {"prettier --write "}},
        },
        html = {
            {cmd = {"prettier --write "}},
        },
        css = {
            {cmd = {"prettier --write "}},
        },
    })

    nvim_create_augroups({
        formatting = {
            {"BufWritePost", "*", "FormatWrite"}
        }
    })

end


-- }}}
-- LSP {{{

config.lsp_install = function()
    for lang in {"python", "typescript", "lua", "yaml", "vim"} do
        require'lspinstall'.install_server(lang)
    end
end

-- }}}
--
config.outline = function()
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false, -- experimental
        position = 'right',
        keymaps = {
            close = "<Esc>",
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            rename_symbol = "r",
            code_actions = "a",
        },
        lsp_blacklist = {"pyls"},
    }
end
 
config.install_lsp_servers = function()
    local language_servers = {"angular", "bash", "cmake", "cpp", "css", "dockerfile", "html", "json", "latex", "lua", "python", "rust", "tailwindcss", "typescript", "yaml"}
    for _, server in pairs(language_servers) do
        require('lspinstall').install_server(server)
    end
end

-- vim.cmd("autocmd BufEnter * lua require('completion').on_attach()")

return config
