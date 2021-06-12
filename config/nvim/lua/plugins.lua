local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

-- Only required if you have packer in your `opt` pack
vim.cmd("packadd packer.nvim")

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    -- Utility Plugins
    -- Plugins that form dependencies for the main functionality I am looking for
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    --
    -- Colourscheme and Themeing Plugins
    --
    use 'sainnhe/edge'
    use 'datwaft/bubbly.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'sunjon/shade.nvim',
        config=function() require('shade').setup() end
    }
    -- This needs a nerd-font patched font, which I am not currently using
    -- use 'kyazdani42/nvim-web-devicons'

    --
    -- Language and Completion Plugins
    --
    -- These are either plugins for parsing the language and colouring or
    -- alternatively for finding completions. This covers all aspects of the
    -- completions, including support for snippets.

    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'nvim-lua/lsp-status.nvim'
    -- Installing language servers
    use {
        'kabouzeid/nvim-lspinstall',
        run = function()
            for lang in {"python", "typescript", "lua", "yaml", "vim"} do
                require'lspinstall'.install_server(lang)
            end
        end

    }

    use 'nvim-lua/completion-nvim'

    use {'nvim-treesitter/nvim-treesitter', run=":TSUpdate"}
    use {
        'nvim-treesitter/completion-treesitter',
        requires="nvim-treesitter/nvim-treesitter"
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires="nvim-treesitter/nvim-treesitter"
    }
    use {
        'simrat39/symbols-outline.nvim',
        config=function()
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
    }



    -- support snippets
    use {'honza/vim-snippets', requires='SirVer/ultisnips'}

    --- Additional support for running formatters
    use 'lukas-reineke/format.nvim'

    use {
        'lewis6991/spellsitter.nvim',
        config=function() require('spellsitter').setup() end,
    }

    -- Enhancing Vim
    -- A collection of plugins for enhancing the general behaviour of vim/neovim.
    -- These are specifically general plugins that work across the board.
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-unimpaired'
    -- Repeat plugin commands
    use 'tpope/vim-repeat'

    use {
        'steelsojka/pears.nvim',
        config=function() require('pears').setup() end
    }

    -- Align symbols within vim
    use {
        'junegunn/vim-easy-align',
        opt = true,
        cmd={"EasyAlign"}
    }

    -- Create signs for modified values
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end,
    }

    --
    -- Utilities for Vim
    --
    -- This provide tools for enhancing specific aspects of the vim experience,
    -- usually through an interface for a specific task.
    use {
        'justinmk/vim-dirvish',
        config=function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end
    }

    use 'tpope/vim-fugitive'

    --
    -- Fuzzy finder
    --
    use {
        'nvim-telescope/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    }
    -- This provides a telescope picker to insert unicode symbols and glyphs
    use {
        'nvim-telescope/telescope-symbols.nvim',
        requires = {'nvim-lua/telescope.nvim'},
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        config=function() require('telescope').load_extension('fzf') end
     }

end)
