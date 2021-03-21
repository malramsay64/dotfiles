--- Utility to simplify the mapping of buffer local bindings
-- @param mode str The mode in which the mapping takes place,
-- this will be one of 'n' for normal mode, 'i' for insert mode
-- or 'v' for visual mode.
-- @param key str The key code that will be used in the mapping
function BufMapper(mode, key, result)
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

--- Utility to simplify the mapping of global bindings
-- @param mode str The mode in which the mapping takes place,
-- this will be one of 'n' for normal mode, 'i' for insert mode
-- or 'v' for visual mode.
-- @param key str The key code that will be used in the mapping
function Mapper(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

function Command(name, code)
    vim.cmd("command! -nargs=0 " .. name .. " " .. code)
end

--- Utility for the creation of autocommand groups
--- @param definitions table A table mapping the name of the group to the
--- definitions that are used within it.
function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end
