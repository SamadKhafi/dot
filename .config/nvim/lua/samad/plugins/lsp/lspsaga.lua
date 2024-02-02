return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    event = { 'LspAttach' },
    config = function()
        require('lspsaga').setup {
            symbol_in_winbar = { enable = true, hide_keyword = true },
            code_action = { show_server_name = true, extend_gitsigns = true },
            lightbulb = { sign = false },
            implement = { enable = true, sign = true, virtual_text = true, priority = 200 },
            ui = {
                border = 'rounded',
                devicon = true,
                -- kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
            },
        }

        local map = vim.keymap.set

        map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = '[LSP] Hover documentation', silent = true })
        map({ 'n', 'v' }, '<leader>la', '<cmd>Lspsaga code_action<CR>', { desc = '[LSP] Code Actions', silent = true })
        map('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', { desc = '[LSP] Rename', silent = true })
        map('n', '<leader>lS', '<cmd>Lspsaga outline<CR>', { desc = '[LSP] Symbols Outline', silent = true })
        map('n', '<leader>li', '<cmd>Lspsaga finder imp<CR>', { desc = '[LSP] Show Implementations', silent = true })
        map({ 'n', 't' }, '<F7>', '<cmd>Lspsaga term_toggle<CR>', { desc = 'Toggle Terminal', silent = true })
    end,
}
