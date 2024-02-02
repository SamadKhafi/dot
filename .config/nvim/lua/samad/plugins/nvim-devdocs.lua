return {
    'luckasRanarison/nvim-devdocs',
    cond = not vim.g.vscode,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    cmd = {
        'DevdocsFetch',
        'DevdocsInstall',
        'DevdocsUninstall',
        'DevdocsOpen',
        'DevdocsOpenFloat',
        'DevdocsUpdate',
        'DevdocsUpdateAll',
    },
    keys = {
        { '<leader>fd', '<cmd>DevdocsOpenCurrentFloat<CR>', desc = '[Find] Devdocs for current file', mode = { 'n' } },
        { '<leader>fD', '<cmd>DevdocsOpenFloat<CR>', desc = '[Find] Devdocs', mode = { 'n' } },
    },
    opts = {
        previewer_cmd = vim.fn.executable 'glow' == 1 and 'glow' or nil,
        cmd_args = { '-s', 'dark', '-w', '80' },
        picker_cmd = true,
        picker_cmd_args = { '-p' },
    },
}
