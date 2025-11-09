return {
    'rmagatti/auto-session',
    lazy = false,
    keys = {
        { '<leader>sr', '<cmd>AutoSession search<CR>', desc = '[Session] Search' },
        { '<leader>ss', '<cmd>AutoSession save<CR>',   desc = '[Session] Save' },
        { '<leader>sd', '<cmd>AutoSession delete<CR>', desc = '[Session] Delete' },
        { '<leader>sa', '<cmd>AutoSession toggle<CR>', desc = '[Session] Toggle' },
    },

    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
        auto_restore = true,
        bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
        session_lens = {
            picker_opts = {
                border = true,
                layout_config = {
                    width = 0.5,
                    height = 0.8,
                },
            },
        },
        suppressed_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop', '/' },
    },
}
