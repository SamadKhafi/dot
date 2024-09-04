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
                'blade-formatter',
                'fixjson',
                'gofumpt',
                'goimports',
                'golines',
                'gomodifytags',
                'gotests',
                'prettierd',
                'stylua',
                'yamlfmt',

                -- formatters & linters
                'cmakelang',
                'djlint',
                'ruff',
                'tlint',

                -- linters
                'eslint_d',
                'golangci-lint',
                'nilaway',
                'stylelint',
                'yamllint',
            },
        }
    end,
}
