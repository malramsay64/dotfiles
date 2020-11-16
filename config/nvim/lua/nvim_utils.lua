--- Helper function that makes setting vim options easier
--- This iterates through each of the options that have been set
--- updating the configuration value within neovim.
---
--- @param options table A mapping of the options to their value
function SetOptions(options)
    for k, v in pairs(options) do
        -- Handle setting of true options
        if v == true then
            vim.api.nvim_command('set ' .. k)
            -- Setting false values requires set no<name>
        elseif v == false then
            vim.api.nvim_command('set no' .. k)
        -- Handle values with containing a mapping
        elseif type(v) == 'table' then
            local values = ''
            -- append each value separated by a comma
            for k2, v2 in pairs(v) do
                if k2 == 1 then
                    values = values .. v2
                else
                    values = values .. ',' .. v2
                end
            end
            vim.api.nvim_command('set ' .. k .. '=' .. values)
        -- Set value directly
        else
            vim.api.nvim_command('set ' .. k .. '=' .. v)
        end
    end
end


--- Utility to simplify the mapping of buffer local bindings
-- @param mode str The mode in which the mapping takes place,
-- this will be one of 'n' for normal mode, 'i' for insert mode
-- or 'v' for visual mode.
-- @param key str The key code that will be used in the mapping
function BufMapper(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

--- Utility to simplify the mapping of global bindings
-- @param mode str The mode in which the mapping takes place,
-- this will be one of 'n' for normal mode, 'i' for insert mode
-- or 'v' for visual mode.
-- @param key str The key code that will be used in the mapping
function Mapper(mode, key, result)
    vim.fn.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

function Command(name, code)
    vim.cmd("command! -nargs=0 " .. name .. " " .. code)
end
