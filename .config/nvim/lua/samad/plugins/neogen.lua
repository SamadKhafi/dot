return {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local neogen = require 'neogen'

        neogen.setup {
            snippet_engine = 'luasnip',
        }

        vim.keymap.set('n', '<leader>ad', neogen.generate, { desc = '[Add] Document Comment', noremap = true, silent = true })
    end,
}
