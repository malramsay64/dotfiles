require('nvim-treesitter.configs').setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"rust", "python", "lua", "toml", "yaml", "html", "typescript", "javascript", "cpp", "bash", "julia", "json"},
    highlight = {
        -- false will disable the whole extension
        enable = true,
    },
    indent = {
        enable = true,
    },
}

