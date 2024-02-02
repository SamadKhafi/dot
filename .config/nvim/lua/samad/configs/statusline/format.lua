local conform = require 'conform'

local Formatters = {
    condition = function()
        return #(conform.list_formatters()) > 0
    end,

    update = { 'BufEnter' },

    provider = function()
        local names = {}
        for _, formatter in pairs(conform.list_formatters()) do
            if formatter.available then
                table.insert(names, formatter.name)
            end
        end
        return '󰃢 ' .. table.concat(names, ', ') .. '  '
    end,

    hl = { fg = 'format', bg = 'bg' },
}

return Formatters
