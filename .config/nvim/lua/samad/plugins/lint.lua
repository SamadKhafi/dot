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
            python = {},
            sass = { 'stylelint' },
            scss = { 'stylelint' },
            -- svelte = { 'eslint_d' },
            templ = { 'golangcilint' },
            -- typescript = { 'eslint_d' },
            yaml = { 'yamllint' },
        }

        -- begin: temporary eslint_d flat config fix --
        local util = require 'lspconfig/util'
        local path = require 'plenary.path'

        local eslint = lint.linters.eslint_d
        eslint.args = {
            '--no-warn-ignored',
            '--format',
            'json',
            '--config',
            function()
                local config_root = util.root_pattern 'eslint.config.js'(vim.api.nvim_buf_get_name(0))
                return util.path.join(path:new(config_root):make_relative(vim.uv.cwd()), 'eslint.config.js')
            end,
            '--stdin',
            '--stdin-filename',
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }
        -- end: temporary eslint_d flat config fix --

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
