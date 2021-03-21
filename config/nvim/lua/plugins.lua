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
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-treesitter/completion-treesitter',
            requires="nvim-treesitter/nvim-treesitter"}
    use {'nvim-treesitter/nvim-treesitter-textobjects',
            requires="nvim-treesitter/nvim-treesitter"}
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/lsp_extensions.nvim'
    -- Installing language servers
    use 'anott03/nvim-lspinstall'
    -- support snippets
    use {'honza/vim-snippets', requires='SirVer/ultisnips'}
    --- Additional support for running formatters
    use 'lukas-reineke/format.nvim'
    use 'tjdevries/nlua.nvim'

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
    use 'tpope/vim-fugitive'
    use 'wincent/corpus'
    -- Fuzzy finder
    use {'nvim-telescope/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    }
    use 'tpope/vim-unimpaired'

    use {'nvim-telescope/telescope-symbols.nvim',
        requires = {'nvim-lua/telescope.nvim'},
        opt = true,
        cmd = {"Telsescope symbols"},
    }
end)
