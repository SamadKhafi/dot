local utils = require 'heirline.utils'

local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.extension = vim.fn.fnamemodify(self.filename, ':e')
        self.filetype = string.lower(vim.bo.filetype)
    end,

    hl = { bg = 'bg' },
}

local FileIcon = {
    init = function(self)
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(self.filename, self.extension, { default = true })
    end,

    provider = function(self)
        if self.filetype == 'nvimtree' or self.filetype == 'neo-tree' then
            return ''
        end

        return self.icon and (self.icon .. ' ')
    end,

    hl = function(self)
        return { fg = self.icon_color, bg = 'bg' }
    end,
}

local FileType = {
    provider = function(self)
        if self.filetype == 'nvimtree' or self.filetype == 'neo-tree' then
            return 'Workspace'
        end

        return self.filetype
    end,

    hl = { fg = 'cyan', bg = 'bg', bold = true },
}

local FileFlags = {
    {
        provider = function()
            if vim.bo.modified then
                return '  '
            else
                return '   '
            end
        end,

        hl = { fg = 'orange', bg = 'bg' },
    },

    {
        condition = function(self)
            if self.filetype == 'nvimtree' or self.filetype == 'neo-tree' then
                return false
            end

            return not vim.bo.modifiable or vim.bo.readonly
        end,

        provider = '  ',

        hl = { fg = 'cyan', bg = 'bg' },
    },
}

local FileNameModifier = {
    hl = function()
        if vim.bo.modified then
            return { fg = 'cyan', bold = true, force = true }
        end
    end,
}

FileNameBlock = utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifier, FileType), FileFlags, { provider = '%<' })

return FileNameBlock
