return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope' },
    keys = {
        {
            '[t',
            function()
                require('todo-comments').jump_prev()
            end,
            desc = 'Previous todo comment',
        },
        {
            ']t',
            function()
                require('todo-comments').jump_next()
            end,
            desc = 'Next todo comment',
        },
        { '<leader>xt', '<cmd>Trouble todo<CR>', desc = '[Trouble] Todo' },
    },
    opts = {
        signs = false,
        keywords = {
            WISH = { icon = ' ', color = 'info' },
            CHORE = { icon = '󰃢 ', color = 'info' },
        },
    },
}
