return {
    'https://git.sr.ht/~p00f/clangd_extensions.nvim',
    config = function()
        require('clangd_extensions').setup {
            ast = {
                role_icons = {
                    type = '',
                    declaration = '',
                    expression = '',
                    specifier = '',
                    statement = '',
                    ['template argument'] = '',
                },
                kind_icons = {
                    Compound = '',
                    Recovery = '',
                    TranslationUnit = '',
                    PackExpansion = '',
                    TemplateTypeParm = '',
                    TemplateTemplateParm = '',
                    TemplateParamObject = '',
                },
            },
        }

        -- C/C++ switch between header and source files
        vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'Switch to header or source' })
    end,
}
