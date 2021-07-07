local plugin_config = require("plugin_config")

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua,plugin_config.lua PackerCompile
  augroup end
]], false)


local use = require('packer').use
return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}

    -- Utility Plugins
    -- Plugins that form dependencies for the main functionality I am looking for
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    --
    -- Colourscheme and Themeing Plugins
    --
    use 'sainnhe/edge'
    use {
        'datwaft/bubbly.nvim',
        config=plugin_config.bubbly
    }
    -- use {
    --     'sunjon/shade.nvim',
    --     config=function() require('shade').setup() end
    -- }
    -- This needs a nerd-font patched font, which I am not currently using
    -- use 'kyazdani42/nvim-web-devicons'

    use { 'lukas-reineke/indent-blankline.nvim' }

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
        config=function()
            vim.cmd[[command InstallLspServers execute lua require("plugin_config").install_lsp_servers()]]
        end
    }

    use {
        "hrsh7th/nvim-compe",
        config=plugin_config.completion,
    }

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
        config=plugin_config.outline,
    }

    --- support snippets
    use {
        'norcalli/snippets.nvim',
        requires='rafamadriz/friendly-snippets',
        config=function() require("snippets").use_suggested_mappings() end
    }

    --- Additional support for running formatters
    use {
        'lukas-reineke/format.nvim',
        config=plugin_config.formatter,
    }

    use {
        'lewis6991/spellsitter.nvim',
        config=function() require('spellsitter').setup({hl="error"}) end,
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
        config=function() require('pears').setup(function(conf)
            conf.pair("<", {filetypes = {"typescript"}})
            conf.on_enter(function(pears_handle)
                if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
                    return vim.fn["compe#confirm"]("<CR>")
                else
                    pears_handle()
                end
            end)
        end
        )
        end
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

    use {
        'tpope/vim-fugitive',
        config=plugin_config.fugitive,
    }

    use {'akinsho/nvim-toggleterm.lua', config=function()
        require('toggleterm').setup({
            open_mapping=[[<space>o]],
            -- No terminal mappings in insert mode
            insert_mappings=false,
            shell="/usr/bin/fish",
        })
    end
    }

    --
    -- Fuzzy finder
    --
    use {
        'nvim-telescope/telescope.nvim',
        requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
        config = plugin_config.telescope,
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
