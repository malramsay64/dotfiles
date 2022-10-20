local plugin_config = require("plugin_config")

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerCompile",
    group = packer_group,
    pattern = 'plugins.lua'
})

return require("packer").startup(function(use)

    -- Packer can manage itself as an optional plugin
    use("wbthomason/packer.nvim")

    -- Colourscheme and Themeing Plugins
    use({
        "sainnhe/edge",
        config = function()
            vim.g.edge_style = "aura"
            vim.g.edge_better_performance = 1
            vim.cmd("colorscheme edge")
        end
    })

    use({
        "nvim-lualine/lualine.nvim",
        config = plugin_config.lualine,
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                char = '┊',
                -- filetype_exclude = { "help", "packer" },
                -- buftype_exclue = { "terminal", "help" },
                show_trailing_blankline_indent = false,
            })
        end,
    })

    --
    -- Language and Completion Plugins
    --
    use("neovim/nvim-lspconfig")
    -- Manage external editor tooling i.e LSP servers
    use 'williamboman/mason.nvim'
    -- Automatically install language servers to stdpath
    use 'williamboman/mason-lspconfig.nvim'

    use({
        "hrsh7th/nvim-cmp",
        requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp-signature-help" },
        config = plugin_config.completion,
    })

    --- support snippets in completion
    use({
        "L3MON4D3/LuaSnip",
        requires = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
        config = plugin_config.snippets
    })

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

    -- Enhancing Vim
    -- A collection of plugins for enhancing the general behaviour of vim/neovim.
    -- These are specifically general plugins that work across the board.
    use("tpope/vim-surround")
    use("tpope/vim-commentary")
    use("tpope/vim-unimpaired")
    -- Detect tabstop and shiftwidth automatically
    use 'tpope/vim-sleuth'
    -- Repeat plugin commands
    use("tpope/vim-repeat")

    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup({}) end
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
    use({
        'malramsay64/mind.nvim',
        -- branch = 'v2.2',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('mind').setup({
                persistence = {
                    -- path where the global mind tree is stored
                    state_path = "~/Documents/mind_notes/mind.json",
                    -- directory where to create global data files
                    data_dir = "~/Documents/mind_notes/data"
                },
                ui = {
                    width = 40,
                    -- Black Leftwards Equilateral Arrowhead U+2B9C
                    select_marker = "⮜",
                }
            })
        end
    })

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
        branch = '0.1.x',
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
        cond = vim.fn.executable "make" == 1,
        config = function()
            require("telescope").load_extension("fzf")
        end
    })
end)
