-- Corpus {{{

CorpusDirectories = {
    ["~/Documents/notes/personal"] = {
        autocommit = false,
        autoreference = 1,
        autotitle = 1,
        base = "./",
        transform = "local"
    },
    ["~/Documents/notes/PhD"] = {
        autocommit = false,
        autoreference = 1,
        autotitle = 1,
        base = "./",
        transform = "local"
    },
    ["~/Documents/Work/Intersect/notes"] = {
        autocommit = false,
        autoreference = 1,
        autotitle = 1,
        base = "./",
        transform = "local"
    },
    ["~/Projects/personal_site/content/post"] = {
        autocommit = false,
        autoreference = 0,
        autotitle = 0,
        base = "post/",
        transform = "web"
    },
}

-- }}}
-- UltiSnips {{{

vim.g.UltiSnipsExpandTrigger = "<c-k>"
vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "~/.config/.nvim/UltiSnips"}
vim.g.ultisnips_python_style = "google"

-- }}}
-- lightline {{{

vim.g.lightline = {
    colorscheme = "edge",
    component = {lineinfo='%3l %-2v'},
    active = {
        left= {
            {'mode', 'paste'},
            {'gitbranch', 'readonly', 'filename', 'modified' },
        },
        right = {
            { 'lineinfo' },
            { 'percent' },
            { 'filetype', 'fileformat' }
        }
    }
}

-- }}}
-- fugitive {{{

Mapper("n", "<space>gs", ":Git<CR>")

-- }}}
-- Completion {{{

vim.g.completion_chain_complete_list = {
    default={
        {complete_items={"lsp", "snippet"}},
        {complete_items={"path"}, triggered_only={"/"}},
    },
}

vim.g.completion_trigger_keyword_length = 2
vim.g.completion_enable_auto_paren = 1
vim.g.completion_enable_snippet = "UltiSnips"

-- }}}
-- telescope {{{

Mapper("n", "<space>p", "<cmd>lua require('telescope.builtin').git_files{}<CR>")
Mapper("n", "<space>f", "<cmd>lua require('telescope.builtin').find_files{}<CR>")
Mapper("n", "<space>gr", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>")
Mapper("n", "<space>en", "<cmd>lua require('telescope.builtin').git_files{cwd = '~/dotfiles'}<CR>")
Mapper("n", "<space>gg", "<cmd>lua require('telescope.builtin').live_grep{}<CR>")
Mapper("n", "<space>tc", "<cmd>lua require('telescope.builtin').commands{}<CR>")
Mapper("n", "<space>tr", "<cmd>lua require('telescope.builtin').registers{}<CR>")
Mapper("n", "<space>ta", "<cmd>lua require('telescope.builtin').autocommands{}<CR>")
Mapper("n", "<space>tk", "<cmd>lua require('telescope.builtin').keymaps{}<CR>")
Mapper("n", "<space>tl", "<cmd>lua require('telescope.builtin').lsp_code_actions{}<CR>")

-- }}}
-- gitsigns {{{

require('gitsigns').setup()

-- }}}
-- dirvish {{{
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- }}}
-- formatter {{{

require("format").setup({
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    -- This uses the local versions of these packages to work within a project.
    python = {
            -- { cmd = {"black"} },
            -- { cmd = {"isort", "--filter-files"} },
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
    }
})

nvim_create_augroups({
     formatting = {
         {"BufWritePost", "*", "FormatWrite"}
     }
 })

-- }}}
