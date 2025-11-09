local auto_session = require 'auto-session.lib'

local Session = {
    condition = function()
        local session = auto_session.current_session_name(true)
        return session ~= nil and #session ~= 0
    end,

    provider = function()
        local session = auto_session.current_session_name(true)
        return ' ' .. session .. '  '
    end,

    hl = { fg = 'session', bg = 'bg' },
}

return Session
