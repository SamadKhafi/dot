return {
    'ray-x/lsp_signature.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    opts = {
        extra_trigger_chars = { '(', ',' },
        floating_window_off_x = 2,
        floating_window_off_y = 0,
        hint_enable = false,
        handler_opts = {
            border = 'rounded',
        },
    },
}
