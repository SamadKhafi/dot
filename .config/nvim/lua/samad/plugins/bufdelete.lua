return {
    'famiu/bufdelete.nvim',
    config = function()
        local bufdelete = require 'bufdelete'
        local map = vim.keymap.set

        map('n', '<leader>c', function()
            bufdelete.bufdelete(0)
        end, { desc = 'Close buffer', silent = true })

        map('n', '<leader>C', function()
            bufdelete.bufdelete(0, true)
        end, { desc = 'Force close buffer', silent = true })
    end,
}
