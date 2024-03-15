local util = require 'lspconfig/util'

return {
    -- disabled auto attaching these servers
    disable = { 'tsserver' },

    -- custom configs for lsp servers
    clangd = {
        capabilities = {
            offsetEncoding = 'utf-8',
        },
    },
    cssls = {
        filetypes = { 'css', 'less', 'sass', 'scss', 'postcss' },
        settings = {
            css = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
            scss = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
            sass = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
            less = {
                validate = true,
                lint = {
                    unknownAtRules = 'ignore',
                },
            },
        },
    },
    emmet_ls = {
        filetypes = {
            'astro',
            'css',
            'eruby',
            'gohtml',
            'html',
            'htmldjango',
            'javascriptreact',
            'less',
            'pug',
            'sass',
            'scss',
            'templ',
            'typescriptreact',
            'vue',
        },
        init_options = {
            options = {
                ['jsx.enabled'] = true,
            },
        },
    },
    gopls = {
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
                -- make the language server recognize 'vim' global
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    -- make language server aware of runtime files
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.stdpath 'config' .. '/lua'] = true,
                    },
                },
            },
        },
    },
    taplo = {
        evenBetterToml = {
            schema = { catalogs = { 'https://www.schemastore.org/api/json/catalog.json' } },
        },
    },
    yamlls = {
        capabilities = {},
    },
}
