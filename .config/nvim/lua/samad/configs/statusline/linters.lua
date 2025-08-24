local lint = require 'lint'
local linter_names = require 'samad.configs.names.linters'

local Linters = {
    -- NOTE: disabled because of bug in nvim-lint
    -- condition = function()
    --     return #(lint.get_running(0)) > 0
    -- end,

    update = { 'BufEnter' },

    provider = function()
        local linters = lint.get_running(0)

        local names = {}
        for _, linter in ipairs(linters) do
            if linter_names[linter] ~= nil then
                table.insert(names, linter_names[linter])
            else
                table.insert(names, linter)
            end
        end

        if #linters > 0 then
            return '󱃲 ' .. table.concat(names, ', ') .. '  '
        end

        return ''
    end,

    hl = { fg = 'lint', bg = 'bg' },
}

return Linters
