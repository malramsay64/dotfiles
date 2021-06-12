require('nvim-treesitter.configs').setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"rust", "python", "lua", "toml", "yaml", "html", "typescript", "javascript", "cpp", "bash", "julia", "json", "css", "scss", "fish"},
    highlight = {
        -- false will disable the whole extension
        enable = true,
    },
    indent = {
        -- There are currently issues with the indentation
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["a,"] = "@parameter.outer",
                ["i,"] = "@parameter.inner",
            }
        }
    },
    swap = {
        enable = true,
        swap_next = {
            [">,"] = "@parameter.inner",
        },
        swap_previous = {
            ["<,"] = "@parameter.inner",
        },
    },
    move = {
        enable = true,
        goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
        },
        goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
        },
        goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
        },
        goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
        },
    },
}
