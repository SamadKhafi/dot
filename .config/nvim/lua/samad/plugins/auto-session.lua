return {
    'rmagatti/auto-session',
    config = function()
        local auto_session = require 'auto-session'

        auto_session.setup {
            auto_restore_enabled = true,
            auto_session_suppress_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop' },
        }

        local map = vim.keymap.set
        map('n', '<leader>sr', '<cmd>SessionRestore<CR>', { desc = '[Session] Restore' })
        map('n', '<leader>ss', '<cmd>SessionSave<CR>', { desc = '[Session] Save' })
    end,
}
