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
                'fixjson',
                'gofumpt',
                'goimports',
                'golines',
                'gomodifytags',
                'gotests',
                'isort',
                'prettierd',
                'rustywind',
                'stylua',
                'yamlfmt',

                -- linters
                'cmakelang', -- formatter
                'djlint', -- formatter
                'eslint_d',
                'golangci-lint',
                'nilaway',
                'pylint',
                'stylelint',
                'yamllint',
            },
        }
    end,
}
