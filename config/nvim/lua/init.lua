require 'nvim_utils'

SetOptions({
    hidden = true, -- allow an unwritten bugger to be hidden
    secure = true, -- Prevent commands running in local files
    title = true, -- set the title of the terminal window
    splitright = true, -- new widows go to the right of the current one
    fileencoding = "utf-8",

    incsearch = true, -- search as characters are entered
    hlsearch = true, -- highlight search matches
    ignorecase = true, -- ignore case when searching
    smartcase = true, -- override ignore case when uppercase
    signcolumn = "yes:1", -- always have a 1 character sign column

    wildmenu = true,
    wildmode = {"longest:full" , "full"}, --

    magic = true, -- Use regular expression magic
    relativenumber = true, -- Use relative line numbers
    number = true, -- except for the current line

    -- Use ripgrep to search within files
    grepprg = [[rg\ --vimgrep\ --smart-case\ --no-heading\ --block-buffered]],

    termguicolors = true, -- Use 24 bit rgb colours in the TUI
    shiftwidth = 4, -- number of spaces to use for autoindent (also >> and <<)
    tabstop = 4, -- number of spaces a tab character is represented as
    softtabstop = 4, -- How a tab is handled in editing
    expandtab = true, -- use spaces in place of tabs
    completeopt={"menu", "menuone", "noinsert", "noselect"},
    shortmess="filnxtToOFc",
    belloff = "all", -- no terminal bells
    listchars = {
        "tab:▶‒",
        "nbsp:␣",
        "extends:»",       --- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
        "precedes:«",      --- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
        "trail:•",      --- BULLET (U+2022, UTF-8: E2 80 A2)
    }
})

vim.g.netrw_banner = 0
vim.g.netrw_liststyle=3
vim.g.email = "malramsay64@gmail.com"
vim.g.username = "Malcolm Ramsay"

-- Configuration of colourscheme
vim.g.edge_style = 'aura'
vim.g.edge_enable_italic = 1

-- Command to remove highlights
Mapper("n", "<space>h", ":nohlsearch<CR>")

-- Use jk for escape, along with common mispellings
Mapper("i", "jk", "<esc>")
Mapper("i", "Jk", "<esc>")
Mapper("i", "jK", "<esc>")
Mapper("i", "JK", "<esc>")

-- Easier command for working with tabs
Mapper("n", "]t", ":tabNext<CR>")
Mapper("n", "[t", ":tabPrev<CR>")

-- TODO -> these mappings don't appear to work, replace with lua command?
Mapper("n", "<C-s>", ":call spelling#fix_previous()<CR>")
Mapper("i", "<C-s>", "<C-g>u<C-o>:call spelling#fix_previous()<CR>")

require('plugin_config')
require('treesitter_config')
require('lsp_config')
