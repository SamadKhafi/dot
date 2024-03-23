local conform = require 'conform'

local Formatters = {
    condition = function()
        return #(conform.list_formatters()) > 0
    end,

    update = { 'BufEnter' },

    provider = function()
        -- skip if current buffer is a readonly buffer
        if not vim.bo.modifiable or vim.bo.readonly then
            return ''
        end

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
