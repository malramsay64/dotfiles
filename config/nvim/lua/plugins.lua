local plugin_config = require("plugin_config")

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { command = "source <afile> | PackerCompile", group = packer_group, pattern = 'plugins.lua' })

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use("wbthomason/packer.nvim")

    -- Colourscheme and Themeing Plugins
    use("sainnhe/edge")

    use({
        "nvim-lualine/lualine.nvim",
        config = plugin_config.lualine,
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                filetype_exclude = { "help", "packer" },
                buftype_exclue = { "terminal", "help" },
                show_trailing_blankline_indent = false,
            })
        end,
    })

    --
    -- Language and Completion Plugins
    --
    -- These are either plugins for parsing the language and colouring or
    -- alternatively for finding completions. This covers all aspects of the
    -- completions, including support for snippets.
    use({
        "nathom/filetype.nvim",
        config = function()
            vim.g.did_load_filetypes = 1
        end,
    })

    use("neovim/nvim-lspconfig")
    use("nvim-lua/lsp_extensions.nvim")
    -- Installing language servers
    use("williamboman/nvim-lsp-installer")

    use({
        "hrsh7th/nvim-cmp",
        config = plugin_config.completion,
    })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
    --- support snippets in completion
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" }, config = plugin_config.snippets })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use({ "nvim-treesitter/playground" })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
        "simrat39/symbols-outline.nvim",
        config = plugin_config.outline,
    })

    --- Additional support for running formatters
    use({
        "lukas-reineke/lsp-format.nvim",
        config = function() require('lsp-format').setup({
                yaml = { tab_width = 2 }
            })
        end
    })

    use({
        "lewis6991/spellsitter.nvim",
        config = function()
            require("spellsitter").setup({ captures = { "comment", "string" } })
        end,
    })

    -- Enhancing Vim
    -- A collection of plugins for enhancing the general behaviour of vim/neovim.
    -- These are specifically general plugins that work across the board.
    use("tpope/vim-surround")
    use("tpope/vim-commentary")
    use("tpope/vim-unimpaired")
    -- Repeat plugin commands
    use("tpope/vim-repeat")

    use({
        "steelsojka/pears.nvim",
        config = function()
            require("pears").setup(function(conf)
                conf.pair("<", { filetypes = { "typescript" } })
                conf.expand_on_enter(false)
            end)
        end
    })

    -- Align symbols within vim
    use({
        "junegunn/vim-easy-align",
        opt = true,
        cmd = { "EasyAlign" },
    })

    --
    -- Utilities for Vim
    --
    -- This provide tools for enhancing specific aspects of the vim experience,
    -- usually through an interface for a specific task.
    use({
        "justinmk/vim-dirvish",
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    })

    use({
        "tpope/vim-fugitive",
        config = plugin_config.fugitive,
    })

    -- Create signs for modified lines within a git repository
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = plugin_config.gitsigns,
    })

    use({
        "akinsho/nvim-toggleterm.lua",
        branch = 'main',
        config = function()
            require("toggleterm").setup({
                open_mapping = [[<space>o]],
                -- No terminal mappings in insert mode
                insert_mappings = false,
                shell = "/usr/bin/fish",
            })
        end,
    })
    use({
        "vimwiki/vimwiki",
        config = plugin_config.vimwiki,
    })

    -- use({ "mickael-menu/zk-nvim", config = plugin_config.zk })

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end
    }

    --
    -- Fuzzy finder
    --
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
        config = plugin_config.telescope,
    })
    -- This provides a telescope picker to insert unicode symbols and glyphs
    use({
        "nvim-telescope/telescope-symbols.nvim",
        requires = { "nvim-lua/telescope.nvim" },
    })
    -- This provides additional speedups in the fuzzy finding by using a native c library
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    })
end)
