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

        -- toggle tailwind conceal
        vim.keymap.set('n', '<leader>uw', '<cmd>TailwindConcealToggle<CR>', {
            desc = '[UI] Toggle Tailwind Fold',
            noremap = true,
            silent = true,
        })

        -- goto previous tailwind classes
        vim.keymap.set('n', '[w', '<cmd>TailwindPrevClass<CR>', {
            desc = '[Tailwind] Previous Class',
            noremap = true,
            silent = true,
        })

        -- goto next tailwind classes
        vim.keymap.set('n', ']w', '<cmd>TailwindNextClass<CR>', {
            desc = '[Tailwind] Next Class',
            noremap = true,
            silent = true,
        })
    end,
}
