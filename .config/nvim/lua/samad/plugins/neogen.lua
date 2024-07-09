return {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local neogen = require 'neogen'

        neogen.setup {
            snippet_engine = 'luasnip',
        }

        vim.keymap.set('n', '<leader>n', '', { desc = 'New' })
        vim.keymap.set('n', '<leader>nd', neogen.generate, { desc = '[New] Document Comment', noremap = true, silent = true })
    end,
}
