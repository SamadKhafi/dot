return {
    'olexsmir/gopher.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },

    config = function()
        local gopher = require 'gopher'

        gopher.setup {
            commands = {
                go = 'go',
                gomodifytags = 'gomodifytags',
                gotests = 'gotests',
                impl = 'impl',
                iferr = 'iferr',
            },
        }

        vim.keymap.set('n', '<leader>g', '', { desc = 'Go/Git' })
        vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>', { desc = '[Go] if Error', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gc', '<cmd>GoCmt<CR>', { desc = '[Go] Document Comment', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gm', '<cmd>GoMod tidy<CR>', { desc = '[Go] Mod tidy', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gt', '<cmd>GoTestAdd<CR>', { desc = '[Go] add Test', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gT', '<cmd>GoTestsAll<CR>', { desc = '[Go] add all Tests', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gj', '<cmd>GoTagAdd json<CR>', { desc = '[Go] add JSON tags', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gJ', '<cmd>GoTagRm json<CR>', { desc = '[Go] remove JSON tags', silent = true, noremap = true })
    end,
}
