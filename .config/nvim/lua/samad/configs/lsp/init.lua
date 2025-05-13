local util = require 'samad.configs.lsp.util'

return {
    -- enable these lsp even if mason package
    -- isn't installed
    enable = { 'biome', 'clangd', 'protols', 'pylsp', 'ruff' },

    -- disabled auto attaching these servers
    disable = {},

    -- custom configs for lsp servers
    clangd = {
        -- removed proto filetype from default list.
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        capabilities = {
            offsetEncoding = 'utf-8',
        },
        init_options = {
            clangdFileStatus = true,
            completeUnimported = true,
            usePlaceholders = false,
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
            'blade',
            'eruby',
            'gohtml',
            'html',
            'htmldjango',
            'javascriptreact',
            'pug',
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
    eslint = {
        settings = {
            experimental = {
                useFlatConfig = true,
            },
        },
    },
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    shadow = true,
                    unusedvariable = true,
                    useany = true,
                },
                codelenses = {
                    run_govulncheck = true,
                    test = true,
                },
                completeFunctionCalls = true,
                completeUnimported = true,
                directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-**/node_modules' },
                experimentalPostfixCompletions = true,
                gofumpt = true,
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                semanticTokens = true,
                staticcheck = true,
                templateExtensions = { 'gohtml' },
                vulncheck = 'Imports',
                usePlaceholders = true,
            },
        },
    },
    intelephense = {
        settings = {
            intelephense = {
                files = { maxSize = 10000000 },
                format = { enable = true, braces = 'allman' },
                stubs = {
                    'apache',
                    'bcmath',
                    'bz2',
                    'calendar',
                    'com_dotnet',
                    'Core',
                    'ctype',
                    'curl',
                    'date',
                    'dba',
                    'dom',
                    'enchant',
                    'exif',
                    'FFI',
                    'fileinfo',
                    'filter',
                    'fpm',
                    'ftp',
                    'gd',
                    'gettext',
                    'gmp',
                    'hash',
                    'iconv',
                    'imap',
                    'intl',
                    'json',
                    'ldap',
                    'libxml',
                    'mbstring',
                    'meta',
                    'mysqli',
                    'oci8',
                    'odbc',
                    'openssl',
                    'pcntl',
                    'pcre',
                    'PDO',
                    'pdo_ibm',
                    'pdo_mysql',
                    'pdo_pgsql',
                    'pdo_sqlite',
                    'pgsql',
                    'Phar',
                    'posix',
                    'pspell',
                    'readline',
                    'Reflection',
                    'session',
                    'shmop',
                    'SimpleXML',
                    'snmp',
                    'soap',
                    'sockets',
                    'sodium',
                    'SPL',
                    'sqlite3',
                    'standard',
                    'superglobals',
                    'sysvmsg',
                    'sysvsem',
                    'sysvshm',
                    'tidy',
                    'tokenizer',
                    'xml',
                    'xmlreader',
                    'xmlrpc',
                    'xmlwriter',
                    'xsl',
                    'Zend OPcache',
                    'zip',
                    'zlib',
                    'wordpress',
                    'wordpress-globals',
                    'acf-pro',
                },
                telemetry = { enabled = false },
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
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
    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    autopep8 = { enabled = false },
                    flake8 = { enabled = false },
                    mccabe = { enabled = false },
                    preload = { enabled = false },
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = false },
                    yapf = { enabled = false },
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
        settings = {
            -- disable yamlls default schema store
            schemaStore = {
                enable = false,
                url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
        },
    },
}
