local conform = require 'conform'
local formatter_names = require 'samad.configs.names.formatters'

local Formatters = {
    condition = function()
        return #(conform.list_formatters_to_run(0)) > 0
    end,

    update = { 'BufEnter' },

    provider = function()
        -- skip if current buffer is a readonly buffer
        if not vim.bo.modifiable or vim.bo.readonly then
            return ''
        end

        local names = {}
        for _, formatter in pairs(conform.list_formatters_to_run(0)) do
            if formatter.available then
                if formatter_names[formatter.name] ~= nil then
                    table.insert(names, formatter_names[formatter.name])
                else
                    table.insert(names, formatter.name)
                end
            end
        end
        return '󰃢 ' .. table.concat(names, ', ') .. '  '
    end,

    hl = { fg = 'format', bg = 'bg' },
}

return Formatters
