return {
    'rcarriga/nvim-notify',
    config = function()
        local notify = require 'notify'

        notify.setup {
            stages = 'static',
        }

        vim.notify = notify
    end,
}
