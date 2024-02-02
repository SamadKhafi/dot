return {
    'williamboman/mason.nvim',
    cmd = {
        'MasonUpdateAll',
        'Mason',
        'MasonInstall',
        'MasonUninstall',
        'MasonUninstallAll',
        'MasonLog',
        'MasonUpdate',
    },
    keys = {
        {
            '<leader>pm',
            '<cmd>Mason<CR>',
            desc = '[Packages] Mason',
            mode = 'n',
            silent = true,
            noremap = true,
        },
    },
    config = function()
        local mason = require 'mason'

        mason.setup {
            ui = {
                border = 'rounded',
                width = 0.8,
                height = 0.8,
                icons = {
                    package_pending = ' ',
                    package_installed = '󰄳 ',
                    package_uninstalled = '󰚌 ',
                },
            },
        }
    end,
}
