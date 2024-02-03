return {
    'kdheepak/lazygit.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        vim.keymap.set('n', '<C-g>', '<cmd>LazyGit<CR>', { desc = '[Git] LazyGit', silent = true, noremap = true })
        vim.keymap.set('n', '<leader>gl', '<cmd>LazyGitFilter<CR>', { desc = '[Git] LazyGit Log', silent = true, noremap = true })
    end,
}
