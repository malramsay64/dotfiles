local config = {}

config.lualine = function()
	require("lualine").setup({
		options = {
			-- U+2502 Box drawings light vertical
			component_separators = "│",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = { "filename", "branch" },
			lualine_c = { "b:gitsigns_status" },
			lualine_x = {
				{
					"diagnostics",
					sections = { "error", "warn", "info", "hint" },
					sources = { "nvim_lsp", "nvim_diagnostic" },
					-- diagnostics_color = {
					--     -- Same values as the general color option can be used here.
					--     error = "DiagnosticError", -- Changes diagnostics' error color.
					--     warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					--     info = "DiagnosticInfo", -- Changes diagnostics' info color.
					--     hint = "DiagnosticHint", -- Changes diagnostics' hint color.
					-- },
					symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				},
			},
			lualine_y = {
				"filetype",
				"progress",
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = { "branch" },
			lualine_c = {},
			lualine_x = { "diff" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "fugitive" },
	})
end

config.bubbly = function()
	vim.g.bubbly_statusline = {
		"mode",
		"truncate",
		"branch",
		"signify",
		"path",
		"divisor",
		"builtinlsp.diagnostics",
		"filetype",
		"progress",
	}

	vim.g.bubbly_palette = {
		background = "#34343c",
		foreground = "#c5cdd9",
		black = "#3e4249",
		red = "#ec7279",
		green = "#a0c980",
		yellow = "#deb974",
		blue = "#6cb6eb",
		purple = "#d38aea",
		cyan = "#5dbbc1",
		white = "#c5cdd9",
		lightgrey = "#57595e",
		darkgrey = "#404247",
	}
end

-- }}}
-- fugitive {{{

config.fugitive = function()
	-- Open a fugitve window in a vertical split on the right hand side of the window
	Mapper("n", "<space>gs", ":vertical rightbelow Git<CR>")
end

-- }}}
-- Gitsigns {{{
require("gitsigns").setup({
	on_attach = function(bufnr)
		local function map(mode, lhs, rhs, opts)
			opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
			vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
		end

		-- Navigation
		map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

		-- Actions
		map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
		map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
		map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
		map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
		map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
		map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
		map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
		map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
		map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

		-- Text object
		map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
		map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

-- }}}
-- Completion {{{

config.completion = function()
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
		},
	})
end

-- }}}
-- telescope {{{

config.telescope = function()
	Mapper("n", "<space>p", "<cmd>lua require('telescope.builtin').git_files{}<CR>")
	Mapper("n", "<space>f", "<cmd>lua require('telescope.builtin').find_files{}<CR>")
	Mapper("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>")
	Mapper("n", "<space>gr", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>")
	Mapper("n", "<space>en", "<cmd>lua require('telescope.builtin').git_files{cwd = '~/dotfiles'}<CR>")
	Mapper("n", "<space>gg", "<cmd>lua require('telescope.builtin').live_grep{}<CR>")
	Mapper("n", "<space>tc", "<cmd>lua require('telescope.builtin').commands{}<CR>")
	Mapper("n", "<space>tr", "<cmd>lua require('telescope.builtin').registers{}<CR>")
	Mapper("n", "<space>ta", "<cmd>lua require('telescope.builtin').autocommands{}<CR>")
	Mapper("n", "<space>tk", "<cmd>lua require('telescope.builtin').keymaps{}<CR>")
	Mapper("n", "<space>tl", "<cmd>lua require('telescope.builtin').lsp_code_actions{}<CR>")

	Mapper("n", "<space>gb", "<cmd>lua require('telescope.builtin').git_branches{}<CR>")
	Mapper("n", "<space>gt", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
	Mapper("n", "<space>gd", "<cmd>lua require('telescope.builtin').git_status{}<CR>")
end

-- }}}
-- formatter {{{

config.formatter = function()
	require("format").setup({
		["*"] = {
			{ cmd = { "sed -i 's/[ \t]*$//'" } }, -- remove trailing whitespace
		},
		-- This uses the local versions of these packages to work within a project.
		python = {
			{ cmd = { "black" } },
			{ cmd = { "isort", "--filter-files" } },
		},
		markdown = {
			{
				cmd = { "black" },
				start_pattern = "^```python",
				end_pattern = "^```",
				target = "current",
			},
		},
		typescript = {
			{ cmd = { "prettier --write " } },
		},
		html = {
			{ cmd = { "prettier --write " } },
		},
		css = {
			{ cmd = { "prettier --write " } },
		},
		lua = {
			{ cmd = { "stylua" } },
		},
	})

	nvim_create_augroups({
		formatting = {
			{ "BufWritePost", "*", "FormatWrite" },
		},
	})
end

-- }}}
-- Code Outline {{{
config.outline = function()
	vim.g.symbols_outline = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false, -- experimental
		position = "right",
		keymaps = {
			close = "<Esc>",
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			rename_symbol = "r",
			code_actions = "a",
		},
	}
end

--}}}
--- Autoclose Pairs {{{

config.pears = function()
	require("pears").setup(function(conf)
		conf.pair("<", { filetypes = { "typescript" } })
		conf.on_enter(function(pears_handle)
			if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
				return vim.fn["compe#confirm"]("<CR>")
			else
				pears_handle()
			end
		end)
	end)
end

-- }}}
-- Snippets

config.snippets = function()
	Mapper("i", "<C-k>", "<cmd>lua require('luasnip').jump(1)<CR>")
	Mapper("i", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>")
	Mapper("s", "<C-k>", "<cmd>lua require('luasnip').jump(1)<CR>")
	Mapper("s", "<C-j>", "<cmd>lua require('luasnip').jump(-1)<CR>")

	local ls = require("luasnip")
	table.insert(ls.snippets.all, ls.snippet("date", require("luasnip.extras").partial(os.date, "%Y-%m-%d")))
end

-- }}}

-- Vimwiki {{{

config.vimwiki = function()
	local base_path = "~/Documents/notes/"

	local base_config = {
		diary_rel_path = "diary/",
		auto_export = 0,
		auto_toc = 1,
		syntax = "markdown",
		ext = ".md",
		nested_syntaxes = { python = "python", sh = "sh" },
	}

	local personal_wiki = vim.deepcopy(base_config)
	personal_wiki.path = base_path .. "personal"

	local asg_wiki = vim.deepcopy(base_config)
	asg_wiki.path = base_path .. "ASG"

	local sapn_wiki = vim.deepcopy(base_config)
	sapn_wiki.path = base_path .. "SAPN"

	vim.g.vimwiki_folding = "syntax"
	vim.g.vimwiki_global_ext = 0
	vim.g.vimwiki_list = { asg_wiki, sapn_wiki, personal_wiki }
	vim.g.vimwiki_key_mappings = { headers = 0 }

	Mapper("n", "<space>wj", ":VimwikiDiaryPrevDay<CR>")
	Mapper("n", "<space>wk", ":VimwikiDiaryNextDay<CR>")
end

-- }}}

return config
