return {
    'https://git.sr.ht/~p00f/clangd_extensions.nvim',
    config = function()
        require('clangd_extensions').setup {}

        -- C/C++ switch between header and source files
        vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'Switch to header or source' })
    end,
}
