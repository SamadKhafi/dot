local highlighter = require 'vim.treesitter.highlighter'

local TreeSitter = {
    condition = function()
        local buf = vim.api.nvim_get_current_buf()

        if highlighter.active[buf] then
            return true
        end

        return false
    end,

    provider = '󰻃  TS  ',

    hl = { fg = 'treesitter', bg = 'bg' },
}

return TreeSitter
