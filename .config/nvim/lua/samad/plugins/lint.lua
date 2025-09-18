return {
    'mfussenegger/nvim-lint',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require 'lint'

        lint.linters_by_ft = {
            blade = { 'tlint' },
            cmake = { 'cmakelint' },
            css = { 'stylelint' },
            gohtml = { 'djlint' },
            -- javascript = { 'eslint_d' },
            less = { 'stylelint' },
            php = { 'tlint' },
            proto = { 'protolint' },
            python = {},
            sass = { 'stylelint' },
            scss = { 'stylelint' },
            -- svelte = { 'eslint_d' },
            templ = { 'golangcilint' },
            -- typescript = { 'eslint_d' },
            yaml = { 'yamllint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set('n', '<leader>ll', function()
            lint.try_lint()
        end, { desc = '[Linter] Refresh Diagnostics' })
    end,
}
