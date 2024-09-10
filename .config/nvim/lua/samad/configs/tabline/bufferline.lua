local utils = require 'heirline.utils'

local function fg(selected)
    return selected and 'cyan' or 'gray'
end

local function bg(selected)
    return selected and 'normal_bg' or 'bg'
end

local Space = {
    provider = ' ',
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
    provider = function(self)
        local filename = self.filename
        filename = filename == '' and '[Untitled]' or vim.fn.fnamemodify(filename, ':t')
        return filename
    end,

    hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
    end,
}

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,

    provider = function(self)
        return self.icon and (self.icon .. ' ')
    end,

    hl = function(self)
        return { fg = self.icon_color }
    end,
}

local TablineFileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
        end,

        provider = ' ',

        hl = { fg = 'orange' },
    },

    {
        condition = function(self)
            return not vim.api.nvim_get_option_value('modifiable', { buf = self.bufnr }) or vim.api.nvim_get_option_value('readonly', { buf = self.bufnr })
        end,

        provider = function(self)
            if vim.api.nvim_get_option_value('buftype', { buf = self.bufnr }) == 'terminal' then
                return ''
            else
                return ''
            end
        end,

        hl = { fg = 'orange' },
    },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,

    hl = function(self)
        return { fg = fg(self.is_active or self.is_visible) }
    end,

    on_click = {
        callback = function(_, minwid, _, button)
            if button == 'm' then -- close on mouse middle click
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = 'heirline_tabline_buffer_callback',
    },

    FileIcon,
    TablineFileName,
    TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
    end,

    Space,

    {
        provider = '',

        hl = function(self)
            return { fg = fg(self.is_active or self.is_visible) }
        end,

        on_click = {
            callback = function(_, minwid)
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                    vim.cmd.redrawtabline()
                end)
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = 'heirline_tabline_close_buffer_callback',
        },
    },
}

-- The final touch!
local TablineBufferBlock = {
    hl = function(self)
        return { bg = bg(self.is_active or self.is_visible) }
    end,

    Space,
    TablineFileNameBlock,
    TablineCloseButton,
    Space,
}

-- and here we go
local BufferLine = utils.make_buflist(
    TablineBufferBlock,

    { provider = '', hl = { fg = 'gray', bg = 'bg' } }, -- left truncation, optional (defaults to "<")
    { provider = '', hl = { fg = 'gray', bg = 'bg' } } -- right truncation also optional (defaults to ...... yep, ">")
)

return BufferLine
