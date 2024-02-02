return {
    'ThePrimeagen/harpoon',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local map = vim.keymap.set

        local mark = require 'harpoon.mark'
        local ui = require 'harpoon.ui'

        map('n', '<leader>hm', function()
            mark.add_file()
        end, { desc = '[Harpoon] Mark' })

        map('n', '<leader>hl', function()
            ui.toggle_quick_menu()
        end, { desc = '[Harpoon] List' })

        map('n', '<leader>hn', function()
            ui.nav_next()
        end, { desc = '[Harpoon] Next' })

        map('n', '<leader>hp', function()
            ui.nav_prev()
        end, { desc = '[Harpoon] Previous' })

        for i = 1, 9, 1 do
            map('n', '<M-' .. i .. '>', function()
                ui.nav_file(i)
            end, { desc = '[Harpoon] File ' .. i })
        end
    end,
}
