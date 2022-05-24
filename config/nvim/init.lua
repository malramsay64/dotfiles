require("plugins")

vim.g.email = "m@malramsay.com"
vim.g.username = "Malcolm Ramsay"

-- Use the space key as the map leader
vim.g.mapleader = " "

-- Always use UTF-8 as the file encoding
vim.opt.fileencoding = "utf-8"
-- no terminal bells
vim.opt.belloff = "all"
-- Always use the sh shell to evaluate commands. This ensures that the various
-- commands are always as fast as possible.
vim.opt.shell = "/bin/sh"

vim.opt.timeoutlen = 200

--- Visual Options

-- set the title of the terminal window
vim.opt.title = true
-- always have a 1 character sign column
vim.opt.signcolumn = "yes:1"
-- Use relative line numbers
vim.opt.relativenumber = true
-- except for the current line
vim.opt.number = true
-- Only redraw the window when we need to
vim.opt.lazyredraw = true
-- new widows go to the right of the current one
vim.opt.splitright = true
-- Use 24 bit rgb colours in the TUI
vim.opt.termguicolors = true
-- Show whitespace characters
vim.opt.list = true
--- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
--- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
--- BULLET (U+2022, UTF-8: E2 80 A2)
vim.opt.listchars = {
    tab = "▶‒",
    nbsp = "␣",
    extends = "»",
    precedes = "«",
    trail = "•",
}
-- Always have 5 lines above or below the cursor
vim.opt.scrolloff = 5

--- Search Options

-- Incremental live completion
vim.opt.inccommand = "nosplit"
-- search as characters are entered
vim.opt.incsearch = true
-- highlight search matches
vim.opt.hlsearch = true
-- ignore case when searching
vim.opt.ignorecase = true
-- override ignore case when uppercase
vim.opt.smartcase = true
-- Use regular expression magic
vim.opt.magic = true
-- Use ripgrep to search within files
vim.opt.grepprg = [[rg --vimgrep --smart-case --no-heading --block-buffered]]

-- allow an unwritten buffer to be hidden
vim.opt.hidden = true
-- Prevent commands running in local files
vim.opt.secure = true

--- Joining lines and newlines
vim.opt.formatoptions = {
    t = false, -- Auto wrap text using textwidth
    c = true, -- Auto wrap comments using textwidth, inserting comment leader automatically
    r = true, -- Insert comment leader after hitting <enter> in insert mode
    o = false, -- Insert comment leader after hitting 'o' or 'O' in Normal mode
    q = true, -- Allow formatting of commetns with gq
    n = true, -- Recognise numbered lists in formatting
    j = true, -- Remove comment leader when joining lines
    l = true, -- Long lines are not broken in insert mode
}
vim.opt.joinspaces = false
-- Wrapping lines will indent at same level as start of line
vim.opt.breakindent = true

--- Completion and Menu Options
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append("c")

--- Spaces and Tabs

-- This doesn't seem to be set using vim.bo, so using the vim commands to set
-- these values.
local spaces = 4
-- -- number of spaces to use for autoindent (also >> and <<)
vim.opt.shiftwidth = spaces
-- -- number of spaces a tab character is represented as
vim.opt.tabstop = spaces
-- -- How a tab is handled in editing
vim.opt.softtabstop = spaces
-- -- use spaces in place of tabs
vim.opt.expandtab = true
-- Only use python3
vim.opt.pyxversion = 3

--- Backups
vim.opt.undofile = true

--- Spelling
vim.opt.spelllang = "en_au"

vim.g.python3_host_prog = "/usr/bin/python3"

-- Configuration of colourscheme
vim.g.edge_style = "aura"
vim.g.edge_enable_italic = 1

-- Folding

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20

-- Command to remove highlights
vim.keymap.set("n", "<space>h", ":nohlsearch<CR>")

-- Use jk for escape, along with common mispellings
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "Jk", "<esc>")
vim.keymap.set("i", "jK", "<esc>")
vim.keymap.set("i", "JK", "<esc>")

-- Easier command for working with tabs
vim.keymap.set("n", "]t", ":tabNext<CR>")
vim.keymap.set("n", "[t", ":tabPrev<CR>")

-- Spelling
vim.keymap.set({ "n", "i" }, "<C-s>", "<Cmd>call spelling#fix_previous()<CR>")

-- Working in the terminal
vim.keymap.set("t", "<C-h>", [[<C-\><C-N><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-N><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-N><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-N><C-w>l]])

-- Remove all trailing whitespace
vim.keymap.set("n", "<space>zz", [[:%s/\s\+$//e<CR>:nohlsearch<CR>]], { silent = true })

-- Commands
vim.api.nvim_create_user_command("Reload", "luafile $MYVIMRC", {})

-- Terminal Confiugartion

local group_terminal = vim.api.nvim_create_augroup("terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", callback = "setlocal nonumber norelativenumber", group = group_terminal })
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", callback = "startinsert", group = group_terminal })

-- Configure nvim to automatically realign windows on resize
local group_resize = vim.api.nvim_create_augroup("resize", { clear = true })
vim.api.nvim_create_autocmd("VimResized", { pattern = "*", callback = ":wincmd =<CR>", group = group_resize })

require("treesitter_config")
require("lsp_config")

--- Set colourscheme
vim.cmd("colorscheme edge")
