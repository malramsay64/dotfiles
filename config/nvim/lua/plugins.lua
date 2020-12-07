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
    use {'Th3Whit3Wolf/onebuddy',
        -- The onebuddy plugin requires the colorbuddy extension to work
        requires = {"tjdevries/colorbuddy.nvim"}
    }

    -- Language and Completion Plugins
    -- These are either plugins for parsing the language and colouring or
    -- alternatively for finding completions. This covers all aspects of the
    -- completions, including support for snippets.
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-treesitter/completion-treesitter',
            requires="nvim-treesitter/nvim-treesitter"}
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    -- support snippets
    use {'honza/vim-snippets', requires='SirVer/ultisnips'}

    -- Enhancing Vim
    -- A collection of plugins for enhancing the general behaviour of vim/neovim.
    -- These are specifically general plugins that work across the board.
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'        -- Repeat plugin commands
    -- Align symbols within vim
    use {'junegunn/vim-easy-align', opt = true, cmd={"EasyAlign"}}

    -- Create signs for modified values
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- Utilities for Vim
    -- This provide tools for enhancing specific aspects of the vim experience,
    -- usually through an interface for a specific task.
    use 'justinmk/vim-dirvish'
    use 'itchyny/lightline.vim'  -- Status line
    use {'tpope/vim-fugitive', opt=true, cmd={"Git"}}
    use 'wincent/corpus'
    -- Fuzzy finder
    use {'nvim-lua/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"}
    }
end)
