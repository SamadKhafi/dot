return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    cmd = { 'MasonToolsClean', 'MasonToolsInstall', 'MasonToolsUpdate' },
    config = function()
        local mason_tool_installer = require 'mason-tool-installer'

        mason_tool_installer.setup {
            ensure_installed = {
                -- formatters
                'beautysh',
                'black',
                'gofumpt',
                'goimports',
                'gomodifytags',
                'gotests',
                'isort',
                'prettierd',
                'stylua',
                'yamlfmt',

                -- linters
                'cmakelang', -- formatter
                'djlint', -- formatter
                'eslint_d',
                'golangcilint',
                'pylint',
                'stylelint',
                'yamllint',
            },
        }
    end,
}
