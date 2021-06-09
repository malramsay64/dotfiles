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

    -- Colourscheme Plugins
    use 'sainnhe/edge'

    -- Language and Completion Plugins
    -- These are either plugins for parsing the language and colouring or
    -- alternatively for finding completions. This covers all aspects of the
    -- completions, including support for snippets.
    use 'neovim/nvim-lspconfig'
    use {'nvim-treesitter/nvim-treesitter', run=":TSUpdate"}
    use {'nvim-treesitter/completion-treesitter',
            requires="nvim-treesitter/nvim-treesitter"}
    use {'nvim-treesitter/nvim-treesitter-textobjects',
            requires="nvim-treesitter/nvim-treesitter"}
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'nvim-lua/lsp-status.nvim'
    -- Installing language servers
    use 'anott03/nvim-lspinstall'
    -- support snippets
    use {'honza/vim-snippets', requires='SirVer/ultisnips'}
    --- Additional support for running formatters
    use 'lukas-reineke/format.nvim'
    use 'tjdevries/nlua.nvim'

    use {'lewis6991/spellsitter.nvim', config=function()
        require('spellsitter').setup()
    end
    }

    -- Enhancing Vim
    -- A collection of plugins for enhancing the general behaviour of vim/neovim.
    -- These are specifically general plugins that work across the board.
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    -- Repeat plugin commands
    use 'tpope/vim-repeat'
    -- Align symbols within vim
    use {'junegunn/vim-easy-align', opt = true, cmd={"EasyAlign"}}

    -- Create signs for modified values
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = "require('gitsigns').setup()",
    }

    -- Utilities for Vim
    -- This provide tools for enhancing specific aspects of the vim experience,
    -- usually through an interface for a specific task.
    use {'justinmk/vim-dirvish', config=function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end}

    use 'tpope/vim-fugitive'
    use 'wincent/corpus'
    use 'tpope/vim-unimpaired'
    use 'datwaft/bubbly.nvim'
    use {'steelsojka/pears.nvim', config="require('pears').setup()"}
    use {'sunjon/shade.nvim', config="require('shade').setup()"}
    use {'simrat39/symbols-outline.nvim', config=function()
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

    -- Fuzzy finder
    use {'nvim-telescope/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    }

    use {'nvim-telescope/telescope-symbols.nvim',
        requires = {'nvim-lua/telescope.nvim'},
        opt = true,
        cmd = {"Telsescope symbols"},
    }

end)
