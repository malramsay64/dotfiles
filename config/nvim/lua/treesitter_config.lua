local nvim_ts_configs = require('nvim-treesitter.configs')

nvim_ts_configs.setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"rust", "python", "markdown", "lua"},
    highlight = {
        -- false will disable the whole extension
        enable = true,
    }
}

