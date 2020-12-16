require('nvim_utils')
require('plugins')

vim.g.email = "malramsay64@gmail.com"
vim.g.username = "Malcolm Ramsay"

SetOptions({
    fileencoding = "utf-8",
    belloff = "all", -- no terminal bells

    -- Visual Options
    title = true, -- set the title of the terminal window
    signcolumn = "yes:1", -- always have a 1 character sign column
    relativenumber = true, -- Use relative line numbers
    number = true, -- except for the current line
    lazyredraw = true, -- Only redraw the window when we need to
    splitright = true, -- new widows go to the right of the current one
    termguicolors = true, -- Use 24 bit rgb colours in the TUI
    list = true, -- Show whitespace characters
    listchars = {
        "tab:▶‒",
        "nbsp:␣",
        "extends:»",       --- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
        "precedes:«",      --- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
        "trail:•",      --- BULLET (U+2022, UTF-8: E2 80 A2)
    },
    scrolloff=5, -- Always have 5 lines above or below the cursor

    --- Search Options
    incsearch = true, -- search as characters are entered
    hlsearch = true, -- highlight search matches
    ignorecase = true, -- ignore case when searching
    smartcase = true, -- override ignore case when uppercase
    magic = true, -- Use regular expression magic
    -- Use ripgrep to search within files
    grepprg = [[rg\ --vimgrep\ --smart-case\ --no-heading\ --block-buffered]],

    hidden = true, -- allow an unwritten bugger to be hidden
    secure = true, -- Prevent commands running in local files

    --- Joining lines and newlines
    formatoptions = "jcroqln",
    joinspaces = false,

    --- Completion and Menu Options
    wildmenu = true,
    wildmode = {"longest:full" , "full"},
    completeopt={"menu", "menuone", "noinsert", "noselect"},
    shortmess="filnxtToOFc",

    --- Spaces and Tabs
    shiftwidth = 4, -- number of spaces to use for autoindent (also >> and <<)
    tabstop = 4, -- number of spaces a tab character is represented as
    softtabstop = 4, -- How a tab is handled in editing
    expandtab = true, -- use spaces in place of tabs

    pyxversion = 3, -- Only use python3

    --- Backups
    undofile = true,

    --- Spelling
    spelllang = "en_au",
})

vim.g.python3_host_prog = "/usr/bin/python3"

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

-- Working in the terminal
Mapper("t", "<C-h>", [[<C-\><C-N><C-w>h]])
Mapper("t", "<C-j>", [[<C-\><C-N><C-w>j]])
Mapper("t", "<C-k>", [[<C-\><C-N><C-w>k]])
Mapper("t", "<C-l>", [[<C-\><C-N><C-w>l]])

-- Remove all trailing whitespace
Mapper("n", "<space>zz", [[:%s/\s\+$//e<CR>]])

-- Commands
Command("Reload", "source $MYVIMRC")

-- Terminal Confiugartion

nvim_create_augroups({
        terminal = {
            {"TermOpen", "*", "setlocal nonumber norelativenumber"},
            {"TermOpen", "*", "startinsert"},
        }
    })

require('plugin_config')
require('treesitter_config')
require('lsp_config')
