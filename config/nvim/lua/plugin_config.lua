-- UltiSnips {{{

vim.g.UltiSnipsExpandTrigger = "<c-k>"
vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "~/.config/.nvim/UltiSnips"}
vim.g.ultisnips_python_style = "google"

-- }}}
-- Statusline {{{

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

-- }}}
-- fugitive {{{

-- Open a fugitve window in a vertical split on the right hand side of the window
Mapper("n", "<space>gs", ":vertical rightbelow Git<CR>")

-- }}}
-- Completion {{{

vim.g.completion_chain_complete_list = {
    default={
        {complete_items={"lsp", "snippet"}},
        {complete_items={"path"}, triggered_only={"/"}},
        {mode: '<c-p>'},
        {mode: '<c-n>'},
    },
}

vim.g.completion_trigger_keyword_length = 2
vim.g.completion_enable_auto_paren = 1
vim.g.completion_enable_snippet = "UltiSnips"
vim.g.completion_trigger_on_delete = 1
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}

-- }}}
-- telescope {{{

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

-- }}}
-- formatter {{{

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
        {cmd = {"prettier"} },
    },
})

nvim_create_augroups({
     formatting = {
         {"BufWritePost", "*", "FormatWrite"}
     }
 })

-- }}}
