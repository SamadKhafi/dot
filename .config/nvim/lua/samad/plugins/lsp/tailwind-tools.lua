return {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'neovim/nvim-lspconfig',
    },
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    opts = {
        document_color = {
            inline_symbol = ' ',
        },
    },
    config = function(_, opts)
        local tailwind = require 'tailwind-tools'

        tailwind.setup(opts)

        vim.keymap.set('n', '<leader>ut', '<cmd>TailwindConcealToggle<CR>', {
            desc = '[UI] Toggle Tailwind Fold',
            noremap = true,
            silent = true,
        })
    end,
}
