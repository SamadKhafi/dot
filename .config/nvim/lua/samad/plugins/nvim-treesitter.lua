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
