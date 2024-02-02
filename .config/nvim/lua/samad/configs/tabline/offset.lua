local Separator = {
    provider = '│',

    hl = { fg = 'divider', bg = 'normal_bg' },
}

local TabLineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        local filetype = vim.bo[bufnr].filetype:lower()
        self.winid = win

        if filetype == 'nvimtree' or filetype == 'neo-tree' then
            self.title = 'File Explorer'
            return true
        end
    end,

    provider = function(self)
        local width = vim.api.nvim_win_get_width(self.winid)

        local title = ' ' .. self.title .. ' '

        -- return ' ' .. title .. string.rep(' ', width - #title - 1)

        local pad = math.floor((width - #title) / 2) - 1 -- -1 for start space
        local pad2 = math.ceil((width - #title) / 2) - 1 -- -1 for end space
        return ' ' .. string.rep(' ', pad) .. title .. string.rep(' ', pad2) .. ' '
    end,

    hl = 'NeoTreeNormal',

    Separator,
}

return TabLineOffset
