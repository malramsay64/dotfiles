require('nvim-treesitter.configs').setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"rust", "python", "lua"},
    highlight = {
        -- false will disable the whole extension
        enable = true,
    },
    indent = {
        enable = true,
    },
}

