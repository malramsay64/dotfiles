-- We use the M to denote the module
local M = {}

M.lualine = function()
    require("lualine").setup({
        options = {
            -- U+2502 Box drawings light vertical
            component_separators = "│",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = {
                { "mode", separator = { left = "" }, right_padding = 2 },
            },
            lualine_b = { "filename", "branch" },
            lualine_c = { "b:gitsigns_status" },
            lualine_x = {
                {
                    "diagnostics",
                    sections = { "error", "warn", "info", "hint" },
                    sources = { "nvim_lsp", "nvim_diagnostic" },
                    -- diagnostics_color = {
                    --     -- Same values as the general color option can be used here.
                    --     error = "DiagnosticError", -- Changes diagnostics' error color.
                    --     warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                    --     info = "DiagnosticInfo", -- Changes diagnostics' info color.
                    --     hint = "DiagnosticHint", -- Changes diagnostics' hint color.
                    -- },
                    symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                },
            },
            lualine_y = {
                "filetype",
                "progress",
            },
            lualine_z = {
                { "location", separator = { right = "" }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { "filename" },
            lualine_b = { "branch" },
            lualine_c = {},
            lualine_x = { "diff" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive" },
    })
end

-- }}}
-- fugitive {{{

M.fugitive = function()
    -- Open a fugitve window in a vertical split on the right hand side of the window
    vim.keymap.set("n", "<space>gs", ":vertical rightbelow Git<CR>")
end

-- }}}
-- Gitsigns {{{

M.gitsigns = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Navigation
            vim.keymap.set("n", "]c", function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { buffer = bufnr, expr = true })

            vim.keymap.set("n", "[c", function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            local opts = { buffer = bufnr }
            -- Actions
            vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
            vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts)
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts)
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
            vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, opts)
            -- vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts)
            -- vim.keymap.set("n", "<leader>hd", gs.diff_this, opts)
            -- vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, opts)
            -- vim.keymap.set("n", "<leader>td", gs.toggle_deleted, opts)

            -- -- Text object
            vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
        end,
    })
end

-- }}}
-- Completion {{{

M.completion = function()
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = 'nvim_lsp_signature_help' },
        },
    })
end

-- }}}
-- telescope {{{

M.telescope = function()
    local telescope_builtin = require("telescope.builtin")

    vim.keymap.set("n", "<space>p", telescope_builtin.git_files, { desc = "[p] Find files in the git repository" })
    vim.keymap.set("n", "<space>f", telescope_builtin.find_files, { desc = "[f] Find [f]iles in the current directory" })
    vim.keymap.set("n", "<space>b", telescope_builtin.buffers, { desc = "[b] Find existing [b]uffers" })
    vim.keymap.set("n", "<space>sr", telescope_builtin.lsp_references)
    vim.keymap.set("n", "<space>sd", function() telescope_builtin.git_files({ cwd = "~/dotfiles" }) end,
        { desc = "[S]earch [D]otfiles directory" })
    vim.keymap.set("n", "<space>sg", telescope_builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<space>sc", telescope_builtin.commands, { desc = "[S]earch vim [C]ommands" })
    vim.keymap.set("n", "<space>sr", telescope_builtin.registers, { desc = "[S]earch vim [R]egisters" })
    vim.keymap.set("n", "<space>sa", telescope_builtin.autocommands, { desc = "[S]earch vim [A]utocommands" })
    vim.keymap.set("n", "<space>sk", telescope_builtin.keymaps, { desc = "[S]earch vim [K]eymaps" })

    vim.keymap.set("n", "<space>gb", telescope_builtin.git_branches)
    vim.keymap.set("n", "<space>gt", telescope_builtin.git_status)
    vim.keymap.set("n", "<space>gd", telescope_builtin.git_status)
end

-- }}}
-- Code Outline {{{
M.outline = function()
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
-- Snippets

M.snippets = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    local ls = require('luasnip')

    local jump_next = function() ls.jump(1) end
    local jump_prev = function() ls.jump(-1) end

    vim.keymap.set({ "i", "s" }, "<C-k>", jump_next)
    vim.keymap.set({ "i", "s" }, "<C-j>", jump_prev)

    ls.add_snippets("all", {
        ls.snippet("date", require("luasnip.extras").partial(os.date, "%Y-%m-%d"))
    })
end

-- }}}

-- Vimwiki {{{

M.vimwiki = function()
    local base_path = "~/Documents/notes/"

    local base_config = {
        diary_rel_path = "diary/",
        auto_export = 0,
        auto_toc = 1,
        syntax = "markdown",
        ext = ".md",
        nested_syntaxes = { python = "python", sh = "sh" },
    }

    local personal_wiki = vim.deepcopy(base_config)
    personal_wiki.path = base_path .. "personal"

    local asg_wiki = vim.deepcopy(base_config)
    asg_wiki.path = base_path .. "ASG"

    local sapn_wiki = vim.deepcopy(base_config)
    sapn_wiki.path = base_path .. "SAPN"

    vim.g.vimwiki_folding = "syntax"
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_list = { asg_wiki, sapn_wiki, personal_wiki }
    vim.g.vimwiki_key_mappings = { headers = 0 }

    vim.keymap.set("n", "<space>wj", ":VimwikiDiaryPrevDay<CR>")
    vim.keymap.set("n", "<space>wk", ":VimwikiDiaryNextDay<CR>")
end

-- }}}
--
-- zk {{{

M.zk = function()
    require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "telescope",

        lsp = {
            -- `config` is passed to `vim.lsp.start_client(config)`
            config = {
                cmd = { "zk", "lsp" },
                name = "zk",
                -- on_attach = ...
                -- etc, see `:h vim.lsp.start_client()`
            },

            -- automatically attach buffers in a zk notebook that match the given filetypes
            auto_attach = {
                enabled = true,
                filetypes = { "markdown" },
            },
        },
    })
    vim.keymap.set("n", "zi", "<cmd>ZkIndex<CR>")
    vim.keymap.set("n", "zn", "<cmd>ZkNew { title = vim.fn.input('Title: ')}<CR>")
    vim.keymap.set("n", "zm", "<cmd>ZkNew { title = vim.fn.input('Title: '), group = 'meeting'}<CR>")
    vim.keymap.set("n", "<space>z", "<cmd>ZkNotes<CR>")
    vim.keymap.set("n", "zl", "<cmd>ZkLinks<CR>")
    vim.keymap.set("n", "zt", "<cmd>ZkTags<CR>")
end

-- }}}

return M
