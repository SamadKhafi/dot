return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local commentstring = require 'ts_context_commentstring'

        -- use bash treesitter parser for zsh
        vim.treesitter.language.register('bash', { 'zsh' })

        -- use css treesitter parser for postcss
        vim.treesitter.language.register('css', { 'postcss' })

        -- use markdown treesitter parser for mdx
        vim.treesitter.language.register('markdown', { 'markdown.mdx' })

        -- use lisp treesitter parser for kicad
        vim.treesitter.language.register('json', { 'kicad.project' })
        vim.treesitter.language.register('commonlisp', { 'kicad.schematic' })
        vim.treesitter.language.register('commonlisp', { 'kicad.board' })
        vim.treesitter.language.register('commonlisp', { 'kicad.symbols' })
        vim.treesitter.language.register('commonlisp', { 'kicad.footprint' })
        vim.treesitter.language.register('commonlisp', { 'kicad.worksheet' })

        -- enable nvim-ts-context-commentstring for commenting tsx and jsx
        commentstring.setup {
            enable_autocmd = false,
        }
    end,
}
