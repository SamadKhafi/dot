local lazy_status = require 'lazy.status'

local LazyStatus = {
    condition = lazy_status.has_updates,

    provider = function()
        local updates = lazy_status.updates()
        return updates .. '   '
    end,

    hl = { fg = 'lazy', bg = 'bg' },

    on_click = {
        callback = function(_, _, _, _, _)
            vim.cmd.Lazy()
        end,
        name = 'OpenLazy',
        update = true,
        winwid = 0,
    },
}

return LazyStatus
