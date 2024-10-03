return {
    'folke/trouble.nvim',
    dependencies = {
        'folke/todo-comments.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Trouble',
    keys = {
        {
            '<leader>x',
            '',
            desc = 'Trouble',
        },
        {
            '<leader>xx',
            '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
            desc = '[Trouble] Toggle',
        },
        {
            '<leader>xw',
            '<cmd>Trouble diagnostics toggle<CR>',
            desc = '[Trouble] Workspace',
        },
        {
            '<leader>xs',
            '<cmd>Trouble symbols toggle focus=false<CR>',
            desc = '[Trouble] Symbols',
        },
        {
            '<leader>xr',
            '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
            desc = '[Trouble] LSP References',
        },
        {
            '<leader>xl',
            '<cmd>Trouble loclist toggle<CR>',
            desc = '[Trouble] Location List',
        },
        {
            '<leader>xq',
            '<cmd>Trouble qflist toggle<CR>',
            desc = '[Trouble] QuickFix',
        },
    },
    opts = {},
}
