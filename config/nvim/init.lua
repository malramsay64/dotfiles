require('nvim_utils')
require('plugins')

vim.g.email = "m@malramsay.com"
vim.g.username = "Malcolm Ramsay"

-- Use the space key as the map leader
vim.g.mapleader = " "

-- Always use UTF-8 as the file encoding
vim.o.fileencoding = "utf-8"
-- no terminal bells
vim.o.belloff = "all"
-- Always use the sh shell to evaluate commands. This ensures that the various
-- commands are always as fast as possible.
vim.o.shell = "/bin/sh"

--- Visual Options

-- set the title of the terminal window
vim.o.title = true
-- always have a 1 character sign column
vim.wo.signcolumn = "yes:1"
-- Use relative line numbers
vim.wo.relativenumber = true
-- except for the current line
vim.wo.number = true
-- Only redraw the window when we need to
vim.o.lazyredraw = true
-- new widows go to the right of the current one
vim.o.splitright = true
-- Use 24 bit rgb colours in the TUI
vim.o.termguicolors = true
-- Show whitespace characters
vim.o.list = true
--- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
--- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
--- BULLET (U+2022, UTF-8: E2 80 A2)
vim.o.listchars = "tab:▶‒,nbsp:␣,extends:»,precedes:«,trail:•"
-- Always have 5 lines above or below the cursor
vim.o.scrolloff=5

--- Search Options

-- search as characters are entered
vim.o.incsearch = true
-- highlight search matches
vim.o.hlsearch = true
-- ignore case when searching
vim.o.ignorecase = true
-- override ignore case when uppercase
vim.o.smartcase = true
-- Use regular expression magic
vim.o.magic = true
-- Use ripgrep to search within files
vim.o.grepprg = [[rg --vimgrep --smart-case --no-heading --block-buffered]]

-- allow an unwritten buffer to be hidden
vim.o.hidden = true
-- Prevent commands running in local files
vim.o.secure = true

--- Joining lines and newlines
vim.o.formatoptions = "jcroqln"
vim.o.joinspaces = false

--- Completion and Menu Options
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.completeopt="menu,menuone,noinsert,noselect"
vim.o.shortmess="filnxtToOFc"

--- Spaces and Tabs

-- number of spaces to use for autoindent (also >> and <<)
vim.bo.shiftwidth = 4
-- number of spaces a tab character is represented as
vim.bo.tabstop = 4
-- How a tab is handled in editing
vim.bo.softtabstop = 4
-- use spaces in place of tabs
vim.bo.expandtab = true
-- Only use python3
vim.o.pyxversion = 3

--- Backups
vim.bo.undofile = true

--- Spelling
vim.o.spelllang = "en_au"

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
Command("Reload", "luafile $MYVIMRC")

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

--- Set colourscheme
vim.cmd("colorscheme edge")
