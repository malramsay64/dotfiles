
-- VimWiki {{{


local home_wiki = {
    path = "~/Documents/notes/personal",
    diary_rel_path = "diary/",
    path_html = "~/Documents/notes/html/personal/",
    auto_export = 0,
    auto_toc = 1,
    syntax = "markdown",
    ext=".md",
    nested_syntaxes = {python="python", sh="sh"},
}


local phd_wiki = {
    path = '~/Documents/notes/PhD/',
    diary_rel_path = 'logbook/',
    diary_index = 'index',
    diary_header = 'PhD Logbook',
    path_html = '~/Documents/notes/html/PhD/',
    html_template = '~/Documents/notes/template.html',
    template_path = '~/Documents/notes/',
    template_default = 'template',
    template_ext = '.html',
    auto_export = 0,
    auto_toc = 1,
    syntax = "markdown",
    ext=".md",
}

local inter_wiki = {
    path = '~/Documents/Work/Intersect/notes/',
    diary_rel_path = 'diary/',
    path_html = '~/Documents/Work/Intersect/html/personal/',
    diary_header = 'Intersect Notes',
    auto_export = 0,
    auto_toc = 1,
    syntax = "markdown",
    ext=".md",
}

vim.g.vimwiki_folding = 'syntax'
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {home_wiki, phd_wiki, inter_wiki}

Mapper("n", "<space>wj", ":VimwikiDiaryPrevDay<CR>")
Mapper("n", "<space>wk", ":VimwikiDiaryNextDay<CR>")

-- }}}
-- UltiSnips {{{

vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
vim.g.UlltiSnipsSnippetDirectories = {"UltiSnips", "~/.config/.nvim/UltiSnips"}

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
