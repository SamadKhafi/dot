local lint = require 'lint'

local Linters = {
    -- NOTE: disabled because of bug in nvim-lint
    -- condition = function()
    --     return #(lint.get_running(0)) > 0
    -- end,

    update = { 'BufEnter' },

    provider = function()
        local linters = lint.get_running(0)

        if #linters > 0 then
            return '󱃲 ' .. table.concat(linters, ', ') .. '  '
        end

        return ''
    end,

    hl = { fg = 'lint', bg = 'bg' },
}

return Linters
