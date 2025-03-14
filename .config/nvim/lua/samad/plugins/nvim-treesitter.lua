return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
    },
    config = function()
        local treesitter = require 'nvim-treesitter.configs'
        local commentstring = require 'ts_context_commentstring'

        -- use bash treesitter parser for zsh
        vim.treesitter.language.register('bash', 'zsh')

        -- use css treesitter parser for postcss
        vim.treesitter.language.register('css', 'postcss')

        -- use markdown treesitter parser for mdx
        vim.treesitter.language.register('markdown', 'markdown.mdx')

        -- use lisp treesitter parser for kicad
        vim.treesitter.language.register('json', 'kicad.project')
        vim.treesitter.language.register('commonlisp', 'kicad.schematic')
        vim.treesitter.language.register('commonlisp', 'kicad.board')
        vim.treesitter.language.register('commonlisp', 'kicad.symbols')
        vim.treesitter.language.register('commonlisp', 'kicad.footprint')
        vim.treesitter.language.register('commonlisp', 'kicad.worksheet')

        treesitter.setup {
            -- enable syntax highlighting
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            -- enable indentation
            indent = { enable = true },
            -- enable autotagging (with nvim-ts-autotag plugin)
            autotag = { enable = true },
            -- ensure these language parsers are installed
            ensure_installed = {
                'arduino',
                'astro',
                'bash',
                'c',
                'cmake',
                'cpp',
                'css',
                'csv',
                'dockerfile',
                'git_config',
                'gitcommit',
                'gitignore',
                'glsl',
                'go',
                'gomod',
                'gosum',
                'html',
                'javascript',
                'json',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'regex',
                'rust',
                'scss',
                'sql',
                'ssh_config',
                'svelte',
                'tsx',
                'toml',
                'typescript',
                'typst',
                'vim',
                'vimdoc',
                'xml',
                'yaml',
                'zig',
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-Space>',
                    node_incremental = '<C-Space>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
        }

        -- enable nvim-ts-context-commentstring for commenting tsx and jsx
        commentstring.setup {
            enable_autocmd = false,
        }
    end,
}
