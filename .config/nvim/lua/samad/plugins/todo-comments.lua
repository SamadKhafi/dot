return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = false,
        keywords = {
            WISH = { icon = ' ', color = 'info' },
            CHORE = { icon = '󰃢 ', color = 'info' },
        },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTelescope', 'TodoTrouble' },
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
        { '<leader>xt', '<cmd>TodoTrouble<CR>', desc = '[Trouble] Todo' },
    },
}
