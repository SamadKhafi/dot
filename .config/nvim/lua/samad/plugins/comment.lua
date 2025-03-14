return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
        local comment = require 'Comment'

        require('ts_context_commentstring').setup {
            languages = {
                c = {
                    __default = '// %s',
                    __multiline = '/* %s */',
                },
            },
        }

        local comment_nvim = require 'ts_context_commentstring.integrations.comment_nvim'

        -- enable comment
        comment.setup {
            toggler = {
                line = '<leader>/',
                block = '<leader>,',
            },
            opleader = {
                line = '<leader>/',
                block = '<leader>,',
            },
            -- for commenting tsx and jsx files
            pre_hook = comment_nvim.create_pre_hook(),
        }
    end,
}
