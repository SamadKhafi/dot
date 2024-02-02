return {
    'folke/tokyonight.nvim',
    enabled = true,
    priority = 1000,
    lazy = false,
    config = function()
        require('tokyonight').setup {}

        vim.cmd.colorscheme 'tokyonight-night'
    end,
}
