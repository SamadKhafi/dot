return {
    'mrjones2014/smart-splits.nvim',
    config = function()
        local splits = require 'smart-splits'

        splits.setup()

        local map = vim.keymap.set

        -- resizing splits
        map('n', '<C-Left>', splits.resize_left)
        map('n', '<C-Right>', splits.resize_right)
        map('n', '<C-Up>', splits.resize_up)
        map('n', '<C-Down>', splits.resize_down)

        -- swapping buffers between windows
        map('n', '<leader><leader>h', splits.swap_buf_left)
        map('n', '<leader><leader>j', splits.swap_buf_down)
        map('n', '<leader><leader>k', splits.swap_buf_up)
        map('n', '<leader><leader>l', splits.swap_buf_right)

        -- NOTE: disabled because of vim-tmux-navigator
        -- moving between splits
        -- map('n', '<C-h>', splits.move_cursor_left)
        -- map('n', '<C-j>', splits.move_cursor_down)
        -- map('n', '<C-k>', splits.move_cursor_up)
        -- map('n', '<C-l>', splits.move_cursor_right)
    end,
}
