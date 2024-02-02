return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local trouble = require 'trouble'

        local map = vim.keymap.set

        map('n', '<leader>xx', function()
            trouble.toggle()
        end, { desc = '[Trouble] Toggle' })

        map('n', '<leader>xw', function()
            trouble.toggle 'workspace_diagnostics'
        end, { desc = '[Trouble] Workspace' })

        map('n', '<leader>xd', function()
            trouble.toggle 'document_diagnostics'
        end, { desc = '[Trouble] Document' })

        map('n', '<leader>xq', function()
            trouble.toggle 'quickfix'
        end, { desc = '[Trouble] QuickFix' })

        map('n', '<leader>xl', function()
            trouble.toggle 'loclist'
        end, { desc = '[Trouble] LocList' })

        map('n', '<leader>xr', function()
            trouble.toggle 'lsp_references'
        end, { desc = '[Trouble] References' })

        trouble.setup {}
    end,
}
